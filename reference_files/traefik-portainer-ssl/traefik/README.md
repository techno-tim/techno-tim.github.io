# Setting A Basic Auth Password
I watched the tutorial twice and couldn't figure out where I was going wrong with setting the password for the dashboard. Here are the steps to follow:
- Install htpasswd if not already installed `sudo apt install apache2-utils`
- Run the following command, replacing 'user' with your username and 'password' with your password:
  - `echo $(htpasswd -nb user password) | sed -e s/\\$/\\$\\$/g`
- Copy the contents of the output and use them as your login username and password for the Dashboard in the config:
  - `- "traefik.http.middlewares.traefik-auth.basicauth.users=user:$$apr1$$b1unmwYj$$n9Dk/2ZIsn5GLrSAEKhju."`
  - Note the format is `<username>:<Hash of Credentials>`. Make sure to include the entire line exactly as it was printed to your terminal.
