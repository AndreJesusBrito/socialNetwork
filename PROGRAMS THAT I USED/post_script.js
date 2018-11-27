const faker = require('faker');
const fs = require('fs');


//generate post 
var name,lastName,sr='',paragraph,h,m,s,ano,mes,dia,rd;
for(var i = 0; i < 2000;i++){
	paragraph = faker.lorem.paragraph();
	ano = Math.floor(Math.random()*(2018-1920))+1920;
	mes = Math.floor(Math.random()*11)+1;
	dia = Math.floor(Math.random()*27)+1;
	h = Math.floor(Math.random()*23);
	m = Math.floor(Math.random()*59);
	s = Math.floor(Math.random()*59);
	rd = Math.floor(Math.random()*499);

	sr+=`insert into post values(
		\r\n \t\'${i}\', \r\n\t to_timestamp(\'${ano}/${mes}/${dia} ${h}:${m}:${s}\',\'YYYY-MM-DD HH24:MI:SS\'),
		\r\n\t'${paragraph}\',
		\r\n\t${rd});\r\n\r\n`;

}
fs.writeFile('C:\Users\Bruno\Documents\GitHub\socialNetwork\PROGRAMS THAT I USED\post.txt', sr,function(err){});


