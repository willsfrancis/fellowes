import { resolve } from 'path'

const pages = [
    {name: 'main', path: resolve(__dirname, './src/index.html')},
    {name: 'our-company', path: resolve(__dirname, './src/our-company.html')},
];

export default pages
