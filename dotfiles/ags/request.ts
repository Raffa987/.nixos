const calls: {
    [index: string]: ((message: string) => void)[]
} = {};

function createCall(call: string) {
    calls[call] = [];
    return calls[call];
}

const requests = {
    listen(call: string, callback: (...args: any) => void): { disconnect(): void } {
        (calls[call] || createCall(call)).push(callback);
        return {
            disconnect() {
                const indx = calls[call].indexOf(callback);
                if (indx == -1) return;
                calls[call].splice(indx, 1);
            }
        }
    },
    send(call: string, ...args: any): void {
        if (!calls[call]) return;
        calls[call].forEach(callback => callback.apply(null, args))
    }
};

export default requests;