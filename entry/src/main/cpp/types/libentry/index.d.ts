export const add: (a: number, b: number) => number;
export const minus: (a: number, b: number) => number;
export const multiply: (a: number, b: number) => number;
export const division: (a: number, b: number) => number;

export const bq_GPIO_On: (ledPath: string) =>  Promise<string>;//节点写1

export const bq_GPIO_Off: (ledPath: string) =>  Promise<string>;//节点写0

export const bq_GPIO_State: (ledPath: string) => Promise<string>;//节点状态查询


export const addAsync:(num1:number, num2: number, callback:(result: number) => void) => void;
//export const addAsync:(num1:number, num2: number) =>Promise<number>;


export function getMd5(value: string): Promise<string>; //异步函数
