# To-do-list-Devera

### I do not own the design

# Things todo

## Features

- [x] Try to code like Hung-Senpai ideas
- [x] Create Forgot password
- [x] Create Todo Home UI
- [x] Create DataStore GraphQL
- [x] Apply AWS to Home UI
- [x] I feel like idiot right now
- [ ] Add create New Task
- [ ] Add create Check List
- [ ] Update My Task UI
- [ ] Sorting Task by Month

## Bugs

- [x] AWS local can't update to AWS cloud
- - <strike>Some how IOS kill connection between local and cloud</strike>
- - Problem: Models CheckList and Type List causing conflict problem when generating code by AWS
- - Solution: Change Type List to Model List (Some how custom type is buggy or I'm idiot)

- [ ] Some how Android is really really laggy
- - No idea why :<

- [ ] Sometimes IOS can't query from AWS cloud
- - Problem: This is bug from AWS Local
- - Solution: Delete App and Hope they will fix it in the next release

- [ ] User NetworkImage Avatar get bug when user sudden;y delete and sign up back to AWS
- - Problem: Duplicate UserID key
- - Solution: ARGGH i don't know how to use AWS Automatic

# Some requirement for this project

- IOS > 13
- Android > 24
- AWS Amplify Service
- Bloc Pattern
- Navigator v2

# Some stupid thing I create

## AWS Data Stores

### Updated: 24-AUG

I change DB a little bit, old DB is idiot :D

<img src="https://firebasestorage.googleapis.com/v0/b/wanders-b9bab.appspot.com/o/Main%20UI%20Images%2FScreen%20Shot%202021-08-24%20at%2021.23.27.png?alt=media&token=dde11b50-cfb1-4e4f-a11d-ff28f2e2b769" width="1000" alt="accessibility text">

# Some confuses

### Why I set username: email in authRepo

Because AWS has 3 options for username which are "username", "email", "phone".

But the sign up function always required username for Login so username is one of them depend on AWS configure

I can't change the rule so yeah that's it.

### Show Dialog

Show Dialog I use pure "Navigator.push"

Because Provider and Navigator kinda mess up when using inside Dialog

```dart
// ./home/home_view.dart
    onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => AddNoteView()));
    }
```

# Some Remind

== <b>In case my future self look back at this not strangle me 👼</b> ==

### Custom Type is suck

AWS generator won't work, it just generate some "Import" and nothing in there

```dart
// ./model/List.dart
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';
```

### Show Dialog push to very different Route

I don't know how to use Show Dialog with Provider yet or it can't
