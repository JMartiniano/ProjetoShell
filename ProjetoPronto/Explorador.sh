#!/bin/bash

source funcoes.sh

menu

# Settings

touch backupSettings.sh
echo -e "#!/bin/bash\nmkdir Backup\nmkdir ./Backup/$(date '+%d.%m.%y')" > backupSettings.sh
chmod u+x backupSettings.sh

