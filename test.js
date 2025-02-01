const iComb = (x) => { return x; }
console.log(iComb(1))

const kComb = (x) => { return (y) => { return x; }; }
console.log(kComb(2)(5))

const sComb = (x) => { return (y) => { return (z) => { return ((x)(z))((y)(z)); }; }; }
let f = (x) => (y) => y(x);
let g = (x) => (y) => y + 1;
console.log(sComb(f)(g)(5));
