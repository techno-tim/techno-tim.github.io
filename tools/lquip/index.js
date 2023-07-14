const lqip = require('lqip');
const fs = require('fs');
const path = require('path');

async function ls(path) {
  console.log('starting')
  const dir = await fs.promises.opendir(path)
  for await (const file of dir) {
    if (file.name.includes('.jpg')) {
      lqip.base64(`${path}/${file.name}`).then(res => {
        console.log(' ')
        console.log(file.name)
        console.log(' ')
        console.log(res); // "data:image/jpeg;base64,/9j/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhY.....
      });
    }
  }
  console.log('done')
}

ls('assets/img/headers').catch(console.error)
ls('assets/img/posts')
.catch(console.error)


