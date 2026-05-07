# roles/alerter
Alerter is a command-line tool for sending macOS notifications (alerts), built with Swift and Swift Package Manager. The program exits when the user interacts with the alert or when it is dismissed, printing the result to stdout as plain text or JSON.



## Dependencies
- homebrew



## Usage
```
$ ./alerter --message|--group|--list [VALUE|ID|ID] [options]

# Examples:
## Display piped data with a sound
$ echo 'Piped Message Data!' | alerter --sound default

## Multiple actions and custom dropdown list
./alerter --message "Deploy now on UAT ?" --actions "Now,Later today,Tomorrow" --dropdownLabel "When ?"

## Yes or No?
./alerter --title ProjectX --subtitle "new tag detected" --message "Deploy now on UAT ?" --closeLabel No --actions Yes --appIcon http://vjeantet.fr/images/logo.png

## What is the name of this release?
./alerter --reply "Type release name" --message "What is the name of this release?" --title "Deploy in progress..."
```


## References
- [vjeantet/alerter: Send User Alert Notification on MacOS from the command-line.](https://github.com/vjeantet/alerter)

