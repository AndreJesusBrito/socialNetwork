const faker = require('faker');
const fs = require('fs');


//generate post 
var rd,sr='',ok;

for(var i = 0; i < 300;i++){
	rd = Math.floor(Math.random()*500);
	sr+=`insert into ProfilePost values(
		\t'${i}',
		\t'${rd}\');
		\r\n\r\n`;	
}
fs.writeFile('C:/Users/Bruno/Documents/GitHub/socialNetwork/PROGRAMS THAT I USED/share_post.sql', sr,function(err){});
