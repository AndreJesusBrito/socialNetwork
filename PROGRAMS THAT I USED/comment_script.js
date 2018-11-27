const faker = require('faker');
const fs = require('fs');


//generate post 
var name,txt,lastName,sr='',paragraph,h,m,s,ano,mes,dia,rd,rdPost;
for(var i = 0; i < 80000;i++){
	paragraph = faker.lorem.paragraph();
	ano = Math.floor(Math.random()*(2018-1920))+1920;
	mes = Math.floor(Math.random()*11)+1;
	dia = Math.floor(Math.random()*27)+1;
	h = Math.floor(Math.random()*23);
	m = Math.floor(Math.random()*59);
	s = Math.floor(Math.random()*59);
	rd = Math.floor(Math.random()*499);
	rdPost = Math.floor(Math.random()*1999);
	txt = Math.round(Math.random()*1);
	sr+=`insert into comment values(
		\r\n\t\'${rdPost}\', 
		\r\n\t\'${i}\',
		\r\n\t\'${txt}',
		\r\n\t to_timestamp(\'${ano}/${mes}/${dia} ${h}:${m}:${s}\',\'YYYY-MM-DD HH24:MI:SS\'),
		\r\n\t${rd});\r\n\r\n`;

}
fs.writeFile('C:\Users\Bruno\Documents\GitHub\socialNetwork\PROGRAMS THAT I USED\comment.sql', sr,function(err){});