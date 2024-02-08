Run these in the following order for sanity's sake:

1. `disable_lid_sleep.sh` to disable lid sleep function (needs `su`) 
2. `create_aliases.sh` to create some fun aliases 
3. `setup_brightness.sh` to create the scripts that will turn the monitor on and off and enable `turnscreen` alias (needs `su`) 
4. `setup_lid_monitor.sh` to create the service to turn off screen brightness when the lid is closed (needs `su`) 

That's it. It should create a `~/.mbp-scripts` folder where it will store some scripts needed by `lid_monitor.service`.
