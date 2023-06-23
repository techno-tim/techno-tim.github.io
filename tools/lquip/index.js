const lqip = require('lqip');
const fs = require('fs');
const path = require('path');

async function ls(path) {
  const dir = await fs.promises.opendir(path)
  for await (const file of dir) {
    if (file.name.includes('.jpg')) {
      lqip.base64(`${path}/${file.name}`).then(res => {
        console.log(file.name)
        console.log(res); // "data:image/jpeg;base64,/9j/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhY.....
      });
    }
  }
}

ls('assets/img/headers').catch(console.error)
// ls('assets/img/posts').catch(console.error)


