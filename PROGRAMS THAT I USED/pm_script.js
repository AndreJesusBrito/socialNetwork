const faker = require('faker');
const fs = require('fs');


//generate post 
var color,pm1,pm2,s,sr='',ok;

for(var i = 0; i < 5000;i++){
	pm1 = Math.floor(Math.random()*499);
	pm2 = Math.floor(Math.random()*499);
	s = faker.lorem.sentence();
	ok = Math.round(Math.random());
	if(pm1 === pm2);
		pm2 = Math.floor(Math.random()*499);
		
	sr+=`insert into pm values(
		\t'${pm1}\',
		\t'${pm2}\',
		\t'${i}\',
		\t'${ok}\',
		\t'${s}\');
		\r\n\r\n`;	
}
fs.writeFile('C:/Users/Bruno/Documents/GitHub/socialNetwork/PROGRAMS THAT I USED/pm_pm.sql', sr,function(err){});
