const faker = require('faker');
const fs = require('fs');


//generate post 
var color,n=9,sr='';
for(var i = 0; i < 176;i++){
	for(var j = 0; j < 9; j++){
	color = faker.internet.color();
	sr+=`insert into role values(
		\t'${i}\',
		\t'${j}\',
		\t'${j}\',
		\t'${color}');
		\r\n\r\n`;
	}

}
fs.writeFile('C:/Users/Bruno/Documents/JS/role.sql', sr,function(err){});
