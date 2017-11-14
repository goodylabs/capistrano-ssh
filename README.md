# capistrano-ssh
Easily connect to remote environment using Capistrano settings.



#### Connect to the 1st server with role `app` from Capistrano staging settings
```
cap-ssh-to-staging.sh
```

#### Connect to 2nd server with role `app` from Capistrano staging settings
```
cap-ssh-to-staging.sh app 2
```

#### Connect to 4th server with role `dj` from Capistrano staging settings
```
cap-ssh-to-production.sh dj 4
```
