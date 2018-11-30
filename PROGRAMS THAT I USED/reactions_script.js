const faker = require('faker');
const fs = require('fs');

const MAX_USERS = 500;
const MAX_POSTS = 2000;

let sr = "";

for(let postID = 0; postID < MAX_POSTS; postID++) {
    const users = [];
    const nReactions = Math.floor(Math.random() * 16);
    rdmFor:
    for(let i = 0; i < nReactions; i++) {
        const reactionType = Math.floor(Math.random() * 2);
        const rdmUserID = Math.floor(Math.random() * MAX_USERS);

        // avoid repetition
        for(let eachID of users) {
            if(rdmUserID === eachID) {
                i--;
                continue rdmFor;
            }
        }

        users.push(rdmUserID);
        sr += `INSERT INTO reactsToPost VALUES (\r\n\t\'${ rdmUserID }\',--userID\r\n\t\'${ postID }\',-- postID\r\n\t\'${ reactionType }\'-- reaction type\r\n);\r\n\r\n`;
    }
}

fs.writeFile('C:\\Users\\André Brito\\Documents\\GitHub\\socialNetwork\\reactsToPost.sql', sr, function(err){});
