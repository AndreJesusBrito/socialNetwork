const faker = require('faker');
const fs = require('fs');


let friends = [];

rdmFor:
for(let i = 0; i < 8000000; i++) {
    const a = [];
    a[0] = Math.floor(Math.random()*250);
    a[1] = Math.floor(Math.random()*250);

    // avoid repetition
    if(a[0] === a[1]) break rdmFor;
    for(let b of friends) {
        if((a[0] === b[0] && a[1] === b[1]) || (a[1] === b[0] && a[0] === b[1])) {
            break rdmFor;
        }
    }
    friends.push(a);
}

let sr = "";

friends.forEach(a => {
    sr += `insert into friend values (\r\n\t\'${a[0]}\',\r\n\t\'${a[1]}\'\r\n);\r\n\r\n`;
});
console.log("genereated:", friends.length);

fs.writeFile('C:\\Users\\André Brito\\Documents\\GitHub\\socialNetwork\\____friends.sql', sr, function(err){});
