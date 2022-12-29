# Install Outline

1. Run script

   ```bash
   sudo -E bash install_wikijs.sh
   ```

   1. Check psql port if other container is running psql.  
      If not running default port(`5432`), change port in config.yml

   ```bash
   cat /etc/postgresql/12/main/postgresql.conf | grep 'port ='
   ```

2. import xml file into task_scheduler on windows
   1. Edit username in action in task scheduler if needed
3. After setup, go to `Administration/Storage` and enable `Local File System`
   1. Set Path to export markdown files

## Additional setup

- PlantUML

  - [plantuml repo](https://github.com/plantuml/plantuml-server)
  - Set plantuml port to 8081
  - replace `https://plantuml.requarks.io` to `http://localhost:8081/plantuml` in wiki before executing `node server`
  - append below in `nohup.sh` in Distro `Backend`

    ```bash
    cd /home/phoi/plantuml-server && mvn jetty:run -Djetty.http.port=8081 &
    ```

## References

- [Setup nginx reverse proxy for wikijs](https://docs-legacy.requarks.io/wiki/admin-guide/setup-nginx)
