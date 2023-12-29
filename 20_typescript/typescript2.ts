// AoC Day20 Part2
import * as fs from 'fs';

class Pulse {
    from: string;
    to: string;
    isHigh: boolean;

    constructor(from: string, to: string, isHigh: boolean) {
        this.from = from;
        this.to = to;
        this.isHigh = isHigh;
    }
}

class Module {
    name: string;
    destinations: string[];

    constructor(name: string, destinations: string[]) {
        this.name = name;
        this.destinations = destinations;
    }

    send(isHigh: boolean): Pulse[] {
        return this.destinations.map(dest => new Pulse(this.name, dest, isHigh));
    }

    receive(from: string, isHigh: boolean): Pulse[] {
        return this.send(isHigh);
    }
}

class Flipflop extends Module {
    isOn: boolean;

    constructor(name: string, destinations: string[]) {
        super(name, destinations);
        this.isOn = false;
    }

    receive(from: string, isHigh: boolean): Pulse[] {
        if (isHigh) {
            return [];
        }
        const res: Pulse[] = this.send(!this.isOn);
        this.isOn = !this.isOn;
        return res;
    }
}

class Conjunction extends Module {
    inputs: Map<string, boolean>;

    constructor(name: string, destinations: string[], sources: string[]) {
        super(name, destinations);
        this.inputs = new Map();
        for (var source of sources) {
            this.inputs.set(source, false);
        }
    }

    receive(from: string, isHigh: boolean): Pulse[] {
        let output: boolean = false;
        this.inputs.set(from, isHigh);
        for (let wasHigh of this.inputs.values()) {
            if (!wasHigh) {
                output = true;
            }
        }
        return this.send(output);
    }
}

class Machines {
    queue: Pulse[];
    map: Map<string, Module>;

    constructor(map: Map<string, Module>) {
        this.queue = [];
        this.map = map;
    }

    repeatButton(): number {
        const periods: Map<string, number> = new Map();
        let count: number = 0;
        while (true) {
            count++;
            this.queue.push(new Pulse('button', 'broadcaster', false));
            while (this.queue.length > 0) {
                const input: Pulse = this.queue.shift()!;
                if (input.to === 'qt' && input.isHigh === true && !periods.has(input.from)) {
                    periods.set(input.from, count);
                    if (periods.size == (this.map.get('qt')! as Conjunction).inputs.size) {
                        const gcd = (x: number, y: number): number => (x === 0 ? y : gcd(y % x, x));
                        const lcm = (x: number, y: number): number => (x * y) / gcd(x, y);
                        return Array.from(periods.values()).reduce((acc, cur) => lcm(acc, cur), 1);
                    }
                }
                const output: Pulse[] = this.map.get(input.to)?.receive(input.from, input.isHigh) ?? [];
                this.queue.push(...output);
            }
        }
    }
}

function getNames(s: string): string[] {
    return s.replace(/[->&%,]/g, ' ').replace(/\s+/g, ' ').trim().split(' ');
}

function main(): void {
    const lines: string[] = fs.readFileSync('/dev/stdin', 'utf8').trim().split('\n');
    const n: number = lines.length;

    const destMap: Map<string, string[]> = new Map();
    const srcMap: Map<string, string[]> = new Map();
    for (let i = 0; i < n; i++) {
        const names: string[] = getNames(lines[i]);
        if (destMap.get(names[0]) === undefined) {
            destMap.set(names[0], []);
        }
        for (let j = 1; j < names.length; j++) {
            if (srcMap.get(names[j]) === undefined) {
                srcMap.set(names[j], []);
            }
            destMap.get(names[0])!.push(names[j]);
            srcMap.get(names[j])!.push(names[0]);
        }
    }

    const modMap: Map<string, Module> = new Map();
    for (let i = 0; i < n; i++) {
        const name: string = getNames(lines[i])[0];
        let module: Module | Flipflop | Conjunction;
        if (lines[i][0] === '%') {
            module = new Flipflop(name, destMap.get(name)!);
        } else if (lines[i][0] === '&') {
            module = new Conjunction(name, destMap.get(name)!, srcMap.get(name)!);
        } else {
            module = new Module(name, destMap.get(name)!);
        }
        modMap.set(name, module);
    }

    const machines: Machines = new Machines(modMap);
    console.log(machines.repeatButton());
}
main();
