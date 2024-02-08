# 💻 Fedora Server Provisioning Scripts for Macbook Pro's
 
## ❔ What's all this here then

This is a collection of provisioning scripts I cobbled together for my **Early 2015 13" Retina Macbook Pro**, which, after having faithfully served me for more than I expected as my daily driver, has now taken on a new assignment as a home server.

The scripts deal with little annoying things, like not being able to keep the machine awake with the lid closed by default, or they install things like Thunderbolt drivers so one can use the Gigabit Ethernet adapter properly.

The scripts were written on, and were only tested for the model mentioned above, the [MacbookPro 12,1 / A1502](https://everymac.com/ultimate-mac-lookup/?search_keywords=MacBookPro12,1) model. I don't expect there should be any difficulty in getting it to work on any other models; as long as devices names like `LID0` and `intel_backlight` remained the same. If not, these should be really easy to adjust.

## 🏃Running these scripts

Run these in the following order for sanity's sake:

1. `disable_lid_sleep.sh` to disable lid sleep function (needs `su`) 
2. `create_aliases.sh` to create some fun aliases
3. `setup_brightness.sh` to create the scripts that will turn the monitor on and off and enable `turnscreen` alias (needs `su`) 
4. `setup_lid_monitor.sh` to create the service to turn off screen brightness when the lid is closed (needs `su`) 

That's it. It should create a `~/.mbp-scripts` folder where it will store some scripts needed by `lid_monitor.service`.
