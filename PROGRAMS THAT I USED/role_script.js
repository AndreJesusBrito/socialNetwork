const faker = require('faker');
const fs = require('fs');


//generate post 
var color,n=9,sr='';
var role = ['apprentice wizard','sensei','el duche','shogun','ebony chieftain','chad mage','legendary sandro','negod'];

for(var i = 0; i < 350;i++){
	for(var j = 0; j < 8;j++){
		color = faker.internet.color();
		sr+=`insert into role values(
		\t'${i}\',
		\t'${role[j]}\',
		\t'${j}\',
		\t'${color}');
		\r\n\r\n`;
	}
}
fs.writeFile('C:/Users/Bruno/Documents/JS/role.sql', sr,function(err){});
