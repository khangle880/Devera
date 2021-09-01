# To-do-list-Devera

### I do not own this beautiful design

[**Design Link.**](https://www.figma.com/file/Lg4BWGwHR2L3Qwk6s0yIHO/Devera-Aking-To-Do-List-App?node-id=0%3A1)<br>

## Table of Contents

- [Requirements](#requirements)
- [Todo](#todo)
  - [Features](#features)
  - [Bugs](#bugs)
- [Things I created](#created)
  - [AWS Schema](#aws)
- [Confuses](#confuses)
- [Reminds](#reminds)
- [WakaTime](#wakatime)

## Requirements for this project<a name = "requirements"></a>

- IOS > 13
- Android > 24
- AWS Amplify Service
- Bloc Pattern
- Navigator v2

## Things todo<a name = "todo"></a>

### Features<a name = "features"></a>

- [x] Try to code like Hung-Senpai ideas
- [x] Create Forgot password
- [x] Create Todo Home UI
- [x] Create DataStore GraphQL
- [x] Apply AWS to Home UI
- [x] I feel like idiot right now
- [x] Update Profile UI
- [x] Add create New Task
- [ ] Add create Check List
- [ ] Create Check List UI
- [x] Update My Task UI
- [x] Sorting Task by Month
- [ ] Create Detail Task

### Bugs <a name = "bugs"></a>

- [x] AWS local can't update to AWS cloud
- - <strike>Some how IOS kill connection between local and cloud</strike>
- - Problem: Models CheckList and Type List causing conflict problem when generating code by AWS
- - Solution: Change Type List to Model List (Some how custom type is buggy or I'm idiot)

- [ ] Some how Android is tremendous lag
- - No idea why. How? :<

- [x] Sometimes IOS can't query from AWS cloud
- - Problem: <strike>This is bug from AWS Local</strike>
- - Problem: Changed DB in cloud causing this bug
- - Solution: Reinstall App will work and Hope they will fix it in the next release

- [x] User NetworkImage Avatar get bug when user suddenly delete and sign up back to AWS
- - Problem: No idea!
- - Solution: I have no idea how i fixed it

- [ ] User date somehow disappeared after pulling from AWS
- - Problem: Schema suddenly changing causing miss match Schema from cloud
- - Solution: Reinstall APP (I know It's idiot)

## Some stupid thing I created<a name = "created"></a>

### AWS Data Stores<a name = "aws"></a>

<b>Updated: 24-AUG</b>

I change DB a little bit, old DB is idiot :D

<img src="https://firebasestorage.googleapis.com/v0/b/wanders-b9bab.appspot.com/o/Main%20UI%20Images%2FScreen%20Shot%202021-08-24%20at%2021.23.27.png?alt=media&token=dde11b50-cfb1-4e4f-a11d-ff28f2e2b769" width="1000" alt="AWS Date Store">

## Some confuses<a name = "confuses"></a>

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

- <b>Updated: 25 - AUG</b>

I found the way to implement Provider but I'm too lazy to change it back LOL!

```dart
// ./profile/profile_view.dart
    void _showImageSourceActionSheet(BuildContext context) {
    Function(ImageSource) selectImageSource = (imageSource) {
      context
          .read<ProfileBloc>()
          .add(OpenImagePicker(imageSource: imageSource));
    };

    if (Platform.isIOS) {
      showCupertinoModalPopup()
    }
}
```

# Some Remind<a name = "reminds"></a>

== <b>In case my future self look back at this not strangle me 👼</b> ==

### Custom Type is suck

AWS generator won't work, it just generate some "Import" and nothing in there

```dart
// ./model/List.dart
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';
```

### Show Dialog push to very different Route

<strike>I don't know how to use Show Dialog with Provider yet or it can't</strike>

Can but kinda tricky to do it :D

### Better using Cubit for multiple view using same Data

```dart
// ./profile/profile_view.dart
    final sessionCubit = context.read<SessionCubit>();
```

Or

```dart
// ./confirm_sign_up/confirm_sign_up_view.dart
    body: BlocProvider(
            create: (context) => ConfirmationBloc(
                  authRepo: context.read<AuthRepository>(),
                  authCubit: context.read<AuthCubit>(),
                ),
            child: _confirmationForm());
```

## Waka time<a name = "wakatime"></a>

[**Waka time.**](https://wakatime.com/@33e747fb-76ec-4602-8c54-d8d22724af34/projects/zszvtourmx?start=2021-08-19&end=2021-08-25)<br>
