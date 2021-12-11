# docker-compose.yml
- In order to properly set your Dashboard password, you will need to encode your credentials.
  - You can use `basic_auth_pass.py` to perform this operation (recommended) or an online form (not recommended).
  - Essentially, you will need to write your credentials in `user:password` format and then encode them into Base64.
  - For example, for a username of "admin" and a password of "mypassword", you need to concatenate them as `admin:mypassword` and then encode this string into Base64 (which would become `YWRtaW46bXlwYXNzd29yZA==`)
  - The python file is the recommended approach as it does not require any external dependencies.
- Once you obtain your credentials, you will replace `USER:BASIC_AUTH_PASSWORD` with the encoded credentials.
  - Using the example credentials `admin:mypassword` above, the line should read `"traefik.http.middlewares.traefik-auth.basicauth.users=YWRtaW46bXlwYXNzd29yZA=="`
