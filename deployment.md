# Deployment Guide 📩

This guide will help you through deploying a `Flutter` application
into the two main app stores in the mobile ecosystem: 
`iOS AppStore` and `Google Play Store`.

Because we are using `Flutter`,
the way one builds, packages and ships an application
will differ from the native way.

So, let's start!

- [Deployment Guide 📩](#deployment-guide-)
  - [🤖 Google `Play Store`](#-google-play-store)
    - [0. Prerequisites](#0-prerequisites)
      - [Creating a `Google Play` account](#creating-a-google-play-account)
      - [Review your app files](#review-your-app-files)
        - [Setting up a splash screen](#setting-up-a-splash-screen)
        - [Adding a launcher icon](#adding-a-launcher-icon)
        - [Reviewing the `AndroidManifest` file](#reviewing-the-androidmanifest-file)
        - [Reviewing the `Gradle` build configuration](#reviewing-the-gradle-build-configuration)
    - [1. Signing the application](#1-signing-the-application)
      - [Creating an upload keystore](#creating-an-upload-keystore)
      - [Reference the keystore from the app](#reference-the-keystore-from-the-app)
    - [2. Building app for release](#2-building-app-for-release)
      - [Build an `app bundle`](#build-an-app-bundle)
      - [Build an `APK`](#build-an-apk)
    - [3. Publishing to `Play Store`](#3-publishing-to-play-store)
    - [4. *(Optional)* ⛓️ Automating deployment with Github Actions](#4-optional-️-automating-deployment-with-github-actions)
      - [Pre-requisites](#pre-requisites)
        - [Create app inside Google Play and set it up](#create-app-inside-google-play-and-set-it-up)
        - [Create a service account and connect it to our app](#create-a-service-account-and-connect-it-to-our-app)
        - [First manual release of app](#first-manual-release-of-app)
        - [Keystore file](#keystore-file)
        - [Gradle file](#gradle-file)
      - [`Github` secrets check-up](#github-secrets-check-up)
      - [A note before releasing a new version](#a-note-before-releasing-a-new-version)
      - [Implementing our workflow file](#implementing-our-workflow-file)
  - [🍏 Apple `App Store`](#-apple-app-store)
    - [0. Prerequisites](#0-prerequisites-1)
      - [Install X-Code](#install-x-code)
      - [Ensure app adheres to the guidelines](#ensure-app-adheres-to-the-guidelines)
      - [Make sure you're enrolled in the `Apple Developer Program`](#make-sure-youre-enrolled-in-the-apple-developer-program)


> [!WARNING]
>
> This guide assumes you have `Flutter` installed.
> If you don't, please check https://github.com/dwyl/learn-flutter
> for more information.

## 🤖 Google `Play Store`

Let's start with Google's `Play Store`!


### 0. Prerequisites

Before we start our guide,
we are going to make sure everything is correctly setup
so **every time we need to deploy, we can go back here and follow the checklist properly**.


#### Creating a `Google Play` account

We first need to create a `Google Play` account,
so we can distribute our applications.
Head over to https://developer.android.com/distribute
and click on `Sign In` on the top right corner.
You may use your personal or company's Google account to do this.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/854713e7-4bfc-4c8d-b1cb-60e548c686fb" />
</p>

After signing in, click on the `Sign in to Play Console`.
This will redirect you to a sign-up page,
where you will need to choose between using a **personal developer account**
or **as part of an organization**.

If you choose the latter, 
you will have to provide additional information.
If you're not using an e-mail with your company's domain,
Google will suggest you to use the "personal account" route.

In this guide's case,
we'll choose the `Yourself` option, 
as it's easier to setup.
What matters here is that we have an account that we can use to publish apps.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/c4033d57-17ca-4339-8bbd-37e8caf80217" />
</p>

Choose the option.
In our case, 
we'll have these requirements.
You'll have to pay a `25 USD` fee in either one.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/8c87b059-7bf3-45e8-a4a0-d63a284f2603" />
</p>

After clicking on `Continue`, you'll have to create a payment profile
for verification purposes.
This payment profile will also be used to pay the registration fee.

Click on `Create or select payments profile`
and go through the steps of adding your debit/credit card.
Once that is finished, 
you may press `Next`.

After clicking `Next`, 
you will be prompted to fill in your **Public Developer Profile**.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/9f9398cf-49b9-4563-8de8-de96b7227949" />
</p>

Just fill the requested fields with your e-mail address,
acknowledging sending the information to Google.

Click `Next`.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/f43b200e-98a3-4ead-9335-88e2854c0304" />
</p>

Fill out the requested information.
Google will ask you for information regarding prior experience
you may have had developing applications in the Play Store.
It will also ask if you've used other Google Accounts
in the `Google Play` ecosystem (this is just to speed up verification).

Fill the requested parameters and click `Next`.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/47de3f0f-ae19-4229-88cf-9cf3d3534c19" />
</p>

In this `Apps` section,
just truthfully answer your app development plans.

Click `Next`.

<p float="left">
  <img src="https://github.com/dwyl/app/assets/17494745/046ac90d-87a0-4757-87a0-28c4b39eaf64" width="49%" />
  <img src="https://github.com/dwyl/app/assets/17494745/29a2bd2f-fb16-4932-93fc-78321f568302" width="49%" />
</p>

Agree to all the terms, 
pay the registration fee and,
upon success, 
you will have your very own developer account! 🎉

After this, you can access your newly created developer account
in the `Play Console` by clicking the `Go to Play Console` button.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/5e184de5-6716-4863-adc0-4139d401b007" />
</p>

You may be asked to finish setting up your account.
You will need to complete the verification
by sending your legal documents so Google knows it's really you
who's creating the account.

**You will need to complete this verification to publish apps on `Google Play`**.



#### Review your app files

Now that we have created an account,
before publishing an app,
we ought to review some files.
It's not necessary to do this *every time* we update the app,
since these changes can be made in one go and be persisted across the development cycle.

*However*, we'll list them here as a preliminary check-up 
before rolling out the first version of the app.


##### Setting up a splash screen

Splash screens (also known as launch screens) 
provide a simple initial experience while the Android app loads. 
They set the stage for your application,
while allowing time for the app engine to load and your app to initialize.

We recommend checking the official guide over at 
https://docs.flutter.dev/platform-integration/android/splash-screen
to set up a simple splash screen.
It's a simple couple of changes that ultimately make a heap of difference!


##### Adding a launcher icon

When a new Flutter app is created, it has a default launcher icon.
To customize this icon, 
the most practical way is using 
[`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons).
By using this package, it will automatically generate icons on all platforms
with the appropriate dimensions, covering all edge cases.


##### Reviewing the `AndroidManifest` file

Reviewing the default [App Manifest](https://developer.android.com/guide/topics/manifest/manifest-intro)
found in `AndroidManifest.xml`,
located in `android/app/src/main`
is important, as it holds relevant information regarding the application
that will be shown on the store.
It also defines permissions needed when using the application.
Two important changes include:

- `application`: editing the `android:label` in the
[application](https://developer.android.com/guide/topics/manifest/application-element) tag will ultimately be the final name of the application.
- `uses-permission`: adding `android.permission.INTERNET`
[permission](https://developer.android.com/guide/topics/manifest/uses-permission-element)
will be needed if the app needs internet access.

##### Reviewing the `Gradle` build configuration

Next up, checking if the [`Gradle build file`](https://developer.android.com/studio/build/#module-level)
located in `android/app` is important for the building phase of the application.
The most important fields to check are:

- `applicationId`, which specifies the [application ID](https://developer.android.com/build/configure-app-module#set-application-id).
- `minSdkVersion`, specifying the [minimum API level](https://developer.android.com/studio/publish/versioning#minsdk) needed to run the app.
With Flutter, it defaults to `flutter.minSdkVersion`,
though you may have to change this specifically sometimes 
if some library requires it.
- `targetSdkVersion`, the target API level the app was designed to run.
Defaults to `flutter.targetSdkVersion`.
- `versionCode`, integer number used as an [internal version number](https://developer.android.com/studio/publish/versioning).
It is used to determine whether one version of the app
is more recent than another. 
**It is not shown to users**.
- `versionName`, version number of the app shown to users.
- `compileSdkVersion`, specifying the API level `Gradle` should use to compile the app.
Defaults to `flutter.compileSdkVersion`.

> [!NOTE]
>
> In `Flutter`, most of these are using default settings from the `Flutter` version.
> In the case of the version names and integers,
> they are fetched from the `pubspec.yaml` file.

### 1. Signing the application

To publish on the `Play Store`,
you need to give the app a digital signature.


#### Creating an upload keystore

On `Android`, there are two different signing keys:
- **deployment key** - end-users that download the [`.apk` file](https://en.wikipedia.org/wiki/Apk_(file_format))
will have this key embedded. 
- **upload key** - is used to authenticate the uploaded `.apk` by developers
onto the `Play Store` 
and is *re-signed with the deployment key* once in the `Play Store`.

So let's create our **upload keystore**!
If you have one, skip this step.
If you *don't*, you have two ways of doing this:

- following the [Android Studio key generation steps](https://developer.android.com/studio/publish/app-signing#sign-apk).
- or running the following commands.

```shell
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \
        -keysize 2048 -validity 10000 -alias upload

```

> [!NOTE]
>
> If you're on Windows, run this in `Powershell`.
>
> ```shell
>   keytool -genkey -v -keystore %userprofile%\upload-keystore.jks ^
>          -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 ^
>          -alias upload
> ```

You may run into this error when running the command.

```
The operation couldn’t be completed. Unable to locate a Java Runtime.
Please visit http://www.java.com for information on installing Java.
```

This means that the `Java` binary needed to run the command
is not in your path.
To fix this, run  `flutter doctor -v` and locate the path that is printed
after `"Java binary at:"`.
After this, **use this path** and replace `java` with `keytool`.

```shell
/Applications/Android\ Studio.app/Contents/jre/Contents/Home/bin/keytool
```

> [!WARNING]
>
> If your path includes space-separated names, 
> such as `Program Files`, use platform-appropriate notation for the names. 
> For example, on Mac/Linux use `Program\ Files`, and on Windows use `"Program Files"`.

Instead of `keytool`, use the path above to run the command. 
You will be prompted to create a password (make sure to remember it!)
and will ask you for some information about yourself.

After this, the keystore should be created
and now it should work 😊.

Running this command will store the `upload-keystore.jks` file in your home directory.
**Do not check this file into public source control**. 
It is meant to be private.


#### Reference the keystore from the app

With the keystore created, 
we need to reference it from the app.
Create a file in `android` called `key.properties`
with the following information.

Fill in the placeholder properties with your own.

```properties
storePassword=<password-from-previous-step>
keyPassword=<password-from-previous-step>
keyAlias=upload
storeFile=<keystore-file-location>
```

The keystore file location,
as it was previously mentioned,
is by default in your homepage.
Check `/Users/<user>/upload-keystore.jks` for it.

**Do not check this file into source control**.
Add it to your `.ignorefile` if it's not already.


Now that we've created our `key.properties` files
with references to our upload keystore,
we need to *use it in our app*.
To do so, 
head over to `android/app/build.gradle` and:

- Add the keystore information from the `key.properties` file
**before the `android` block**.

```gradle
   def keystoreProperties = new Properties()
   def keystorePropertiesFile = rootProject.file('key.properties')
   if (keystorePropertiesFile.exists()) {
       keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
   }

   android {
         ...
   }
```

- Find the `buildTypes` block.

```gradle
   buildTypes {
       release {
           // TODO: Add your own signing config for the release build.
           // Signing with the debug keys for now,
           // so `flutter run --release` works.
           signingConfig signingConfigs.debug
       }
   }
```

And replace it with the following.

```gradle
   signingConfigs {
       release {
           keyAlias keystoreProperties['keyAlias']
           keyPassword keystoreProperties['keyPassword']
           storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
           storePassword keystoreProperties['storePassword']
       }
   }
   buildTypes {
       release {
           signingConfig signingConfigs.release
       }
   }
```

Congratulations! 
Release builds of your app will now be signed automatically! 🥳

For good measure, 
run `flutter clean` after making these changes.
Some cached builds might linger from before these changes,
so we want to clear that possibility straight away.


### 2. Building app for release

With our signing keystore ready to go,
we can now create **release bundles**.

At this stage, before creating a release bundle,
you may want to consider [obfuscating your Dart source code](https://docs.flutter.dev/deployment/obfuscate)
to make it difficult to reverse engineer.

This can bring security benefits,
prevent competitors, hackers or malicious actors from reverse-engineering your app
and safeguard proprietary algorithms or paid features from being copied or used.
It can additionally reduce the size of the Flutter app,
which is always a plus ➕.

To do this, we only just need to add a couple of flags
to the build command,
and maintain additional files to de-obfuscate stack traces
in case the app crashes.

> [!NOTE]
>
> For more information on how to de-obfuscate a stack trace,
> check https://docs.flutter.dev/deployment/obfuscate#read-an-obfuscated-stack-trace.
> It will explain the `flutter symbolize` command that is used for this effect.


Now can release our app in two formats to later be published to the `Play Store`:

- **`app bundle`** (recommended).
- **`APK`**.


Let's go over each one.

> [!NOTE]
>
> Before making the bundle release,
> you need to increase the `version` of the app
> in the `pubspec.yaml` file.


#### Build an `app bundle`

If you are keen in knowing *why* releasing `app bundles` is better,
follow https://developer.android.com/guide/app-bundle.
Making long story short, you're deferring APK generation 
and signing to Google Play.
They will optimize your app for you for each device,
making this much easier on our side.

In fact, from August 2021, `Google Play` **requires** apps
to be published in this format.

Let's create our `app bundle`!

Go to your project folder, and simply run:

```shell
flutter build appbundle
```

> [!NOTE]
>
> If you want to obfuscate your code, run:
> ```shell
> flutter build appbundle --obfuscate --split-debug-info=/<project-name>/<directory>
> ```

This will show the output of the `aab` file,
the app bundle.

Now, if we want to test this bundle tool, 
we can do so in two ways:

- **offline**, by using the [`bundletool`](https://github.com/google/bundletool) command.
After installing this, you will **generate `apk` files which you can run**
to test the application.
For this, simply run `bundletool build-apks --bundle=<path_of_aab> output=<output_folder>`.
For example,

```shell
bundletool build-apks --bundle build/app/outputs/bundle/release/app-release.aab --output build_aab_apks/app-release.apks
```

This will create a folder `build_aab_apks` with the `.apk` file that you can run on a device to test it.
Now, you can plug in your device to the computer
and run `bundletool install-apks --apks=build_aab_apks/app-release.apks` 
(change the location of the `.apks` you've created accordingly).

- **using `Google Play`**, by uploading the bundle to `Google Play`
to test it. You should use the internal test track, or alpha/beta channels 
to test the bundle before production.
For this, simply follow the instructions in https://developer.android.com/studio/publish/upload-bundle.


#### Build an `APK`

Although `app bundles` are required to publish to the `Play Store`,
you may want to publish your app in other stores,
which may not yet support `app bundles`.
For this, just release the `APK` for each [target ABI](https://en.wikipedia.org/wiki/Application_binary_interface).

Go to your project folder, and simply run:

```shell
flutter build apk --split-per-abi
```

> [!NOTE]
>
> If you want to obfuscate your code, run:
> ```shell
> flutter build apk --split-per-abi --obfuscate --split-debug-info=/<project-name>/<directory>
> ```

This command will create **three `APK` files**
in `/build/app/outputs/apk/release/`.

To test this `APK`, it's quite easy.
Similarly to before,
connect your Android device to your computer,
go to your project folder
and run `flutter install`.


### 3. Publishing to `Play Store`

Now that we have our `app bundle` ready,
we ought to deploy it to `Play Store`.
For a more in-depth tutorial, please check https://developer.android.com/distribute.


//TODO add steps after getting verified


### 4. *(Optional)* ⛓️ Automating deployment with Github Actions

Now that we know how to build,
bundle and release our app to the public,
it's time to learn how to automate this process!

Ideally, you will want *at least* two separate environments
when deploying your application.
Many teams work with three different branches/environments 
during the development cycle of any application:

- `production`: the production version of the app.
It's the stable version of the application that is shown to the end-client.
- [`UAT`](https://uit.stanford.edu/pmo/UAT): also known as "staging".
Can be thought out as a "pre-production" environment that is meant 
to test the application with a small group of people 
before being shipped into the `production` branch/env.
- `dev`: branch for the development.
Only accessible for developers and will not affect any real data
from real clients.


Therefore, you **should employ different workflows and builds for each env**.
You should have a `prod`, `UAT` and `dev` version of your application.

However, for sake of brevity and simplicity, 
we'll show you a way of automating the workflow 
**only for one branch** 
(in this case, we'll consider it to be the `prod`/`main` branch).


#### Pre-requisites

Before proceeding with creating our own Github Actions workflow file,
we need to sort some pre-requisites 
that are **mandatory** in order for everything to work.

Let's go through them right now.


##### Create app inside Google Play and set it up

Firstly, you need to create an app project in your 
`Google Play Console` account.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/b0fb7cc6-c5f9-4b7f-a173-3f9d0791808d" />
</p>

Go to https://console.cloud.google.com/home/dashboard,
head to `All Apps` section to the left
and click on the **`Create app`** button.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/72c92aab-5d8b-4a7a-8246-9d1549744469" />
</p>

Follow through the instructions in the page and click on 
`Create app` once you're finished.
You will create a new **app project**,
with its own dashboard and settings.

You will be redirected to the `Dashboard` page 
of your newly created app, like shown in the picture below.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/d60cc985-fd16-40f3-a911-819b989a7354" />
</p>

You will see that, in order to be able to access some features
shown in the page,
you will have to first **set the app**.
This means giving information about the application,
what it does, who it is meant for, and a myriad of other information.

You will need to go through **each required option**
and fill the information.

Like in the picture above, 
you'll want to have all the steps completed in order to continue.
For each one, you'll have a button redirecting you
to a specific page where you'll fill out the requested information.

After completing all of these steps, 
you will be cleared to continue! 🥳


##### Create a service account and connect it to our app

Now that we've set everything up in our app,
we will need to create a [**service account**](https://cloud.google.com/iam/docs/service-account-overview).
A service account will be the agent that will use the `Google Play API`
to upload new releases of our app.

Let's create this account and add it to our account.

First, we are going to head over to **`Google Cloud Console`**
and create a new project.
Head over to https://console.cloud.google.com/projectcreate
and create your own project.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/e23c0e72-d9ab-4b46-820b-8468fa462bd8" />
</p>

After that, we need to **enable the API**
in our `Google Cloud` project we've just created.
For this, go to https://console.developers.google.com/apis/api/androidpublisher.googleapis.com/,
choose the project and enable `Google Play Developer API`.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/a7d417a7-21c7-4157-ac0d-c95bce27c172" />
</p>


Awesome! 👏

Now we are ready to *create a service account*.
For this, head over to 
https://console.cloud.google.com/iam-admin/serviceaccounts,
and select your project.
You are now in the `Service Accounts` tab.

Click on `Create service account` and follow the steps.

<p align="center">
  <img width="49%" src="https://github.com/dwyl/app/assets/17494745/28840fb5-ca52-49c2-b9d7-6e42b0db94d2" />
  <img width="49%" src="https://github.com/dwyl/app/assets/17494745/1dba5801-8f9b-47ba-8fb3-38bcfa07b31b" />
</p>

After these, you will have created a service account.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/3c17884f-25f7-4d26-a2e0-01017e292893" />
</p>


Next, go to the `Users & Permissions` page
and click on `Invite new users`.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/5c7b85bb-68fb-485a-8cad-07c186646af6" />
</p>

Put an e-mail address for your service account in the `email address` field,
and grant the necessary rights to perform actions.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/82abd924-2b85-4607-97be-2729e527620f" />
</p>

Grant the following permissions:

- Admin (all permissions)

> [!NOTE]
>
> You can definitely narrow the permissions down.
> We're giving all the permissions to make this as simple as possible
> for you 😀.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/3c805122-7fb8-46a6-b54b-a8e6ef210c68" />
</p>

After setting the permissions, just click `Invite user`!

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/38160928-2002-4798-8a44-f841091fd29b" />
</p>

After clicking it, you will see that you've just created
your very own service account!

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/34eabc59-3eb7-4124-b8e8-23334b66325d" />
</p>


Now that we have our service account, 
**all that's left is retrieving the `json` file that holds its keys**,
so that we can use it in our workflow!

Head over to https://console.cloud.google.com/iam-admin/serviceaccounts/,
which will lead you to `IAM & Admin` and to `Service Accounts`
inside `Google Cloud Console`.

In here, choose the service account you've just created,
click on the `Actions` icon 
and click on `Manage keys`.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/5b5bc556-a745-4361-8a5a-44bfe3729c23" />
</p>

Then, click on `Add key` and `Create new key`.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/104440fe-4f6c-4711-b40a-71a72e1fe168" />
</p>

Now, click on the `JSON` option.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/995c7417-4b70-4e7e-8457-2fcd264c4499" />
</p>

Once you do this,
a `json` file will automatically download.
**Do not share this `json` file with anyone**.
It contains *private keys*.

And that's it!
Great job so far! 🎉


##### First manual release of app

In order to automate our app release,
we first need to do it manually (only for the first time).
This is because the app does not yet exist
and we haven’t uploaded the first artifact 
to our `Google Play` application manually.

With this in mind, 
let's create our first release!

Head over to `Google Play Console`
at https://play.google.com/console
and select the app you've created prior.
Then, head over to `Production`
on the left tab,
and create `New release`.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/abc219d2-5802-456e-88aa-49794e50956d" />
</p>

You will be prompted a page
in which you you will add details to the release.

You will first need to choose
how your apps will be signed.
Choose the first option,
in which Google itself will sign the apps for you.

Then, you will need to upload the app bundle.
If you've executed the commands properly,
the default path in which this bundle lives
should be 
`build/app/outputs/bundle/release/app-release.aab`.

Finally, add a release name.

<p align="center">
  <img width="32%" src="https://github.com/dwyl/app/assets/17494745/5004674d-dc58-47bc-a1d9-44a043d3ed66" />
  <img width="33%" src="https://github.com/dwyl/app/assets/17494745/b20718c2-ea83-42c5-a635-6ca0881bb413" />
  <img width="33%" src="https://github.com/dwyl/app/assets/17494745/9353cee4-50aa-4562-97ae-a6ba083ad2f5" />
</p>

After this,
proceed with the instructions.
You will be shown a preview page, like so:

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/685812ab-08ce-42d0-be44-8cc40f3e2d65" />
</p>


> [!WARNING]
>
> If you are shown errors, like in the picture below, 
> you'll need to sort those out in order to continue.
>
> <p align="center">
>  <img width="800" src="https://github.com/dwyl/app/assets/17494745/300ceff7-876a-47d4-a2d6-c7e4a05a0a72" />
> </p>
>
> This means the app wasn't initially set up all the way through.
> Click on each error and fix it, following instructions.


After this,
click on `Create release`
and that's it!
You've just created the first release of your application!

Remember, this was needed in order to automate
the release process in the future.


##### Keystore file

Even before publishing your app,
you would have needed an **upload keystore**.

If you haven't created one,
please go to [Creating an upload keystore](#creating-an-upload-keystore)
and follow the instructions.


##### Gradle file

You need to make some adjustments to the `android/app/build.gradle` file.
Head over to [Reference the keystore from the app](#reference-the-keystore-from-the-app)
to make the needed modifications.



#### `Github` secrets check-up

Now that all the pre-requisites are fulfilled,
before proceeding with implementing 
our Github Action workflow file,
we need to 
**define a set of repository secrets**
that will later be used in it.

Here are the secrets that you will need to have implemented
in your repository.

- `KEYSTORE_FILE_BASE64`, 
this is the uploaded file encoded
as a *base64 string*.
**You should have one keystore per environment**.
In our case, we'll just have one,
for production release.

To encode the upload keystore file 
into a [base64](https://en.wikipedia.org/wiki/Base64) string,
you can run the following command (on `MacOS` and `Linux`).

```sh
base64 -i company_prod_keystore.jks -o company_prod_keystore.jks.base64
```

You can then copy the `company_prod_keystore.jks.base64` contents
into the secret.

- `KEYSTORE_PASSWORD`: the keystore password that is present
in the upload keystore file.
It is the password that will be used by the Android build command 
to decode the keystore itself.

- `KEYSTORE_KEY_ALIAS`: a simple key, you can choose pretty much anything. 
For example, use `my_company` as an alias for prod 
and `my_company_uat` for UAT.
Can be the same as the one found in the upload keystore file.

- `KEYSTORE_KEY_PASSWORD`: the keystore key password that is present
in the upload keystore file.
It is a password that will be used by the Android build command 
to decode the key inside the keystore. 
It is identical to `KEYSTORE_PASSWORD`.

- `GOOGLE_PLAY_SERVICE_ACCOUNT_KEY_JSON`: the contents
of the service account `json` file 
that we downloaded earlier.

After you've set all of these secrets,
we are now ready to roll! 🛼


#### A note before releasing a new version

When you merge a new feature to the `main`/`prod` branch
or want to release a new version of your app,
don't forget to upgrade the version
in your `pubspec.yaml` file.

We recommend you upgrade the version
with the following format.

`A.B.C+X`

`A.B.C` represents the `versionName` such as 1.0.0.

`X` (the number after the +) represents the `versionCode` such as 1, 2, 3, etc.

You can check [Android's reference link](http://developer.android.com/guide/topics/manifest/manifest-element.html)
to understand the difference between `versionName` and `versionCode`.
But, to put it simply, 
the `versionCode` is **an internal version number** that is used
to determine whether one version is more recent than another.
`versionName` is the version name shown to the end-user.

Therefore, for each release, you are **obliged to increase the `versionCode`
for the new release and workflow to work.
You can maintain the version that is *shown to the user*
by silently maintaining the `versionName` and increasing the `versionCode`.

For more information, 
please check 
https://stackoverflow.com/questions/53570575/flutter-upgrade-the-version-code-for-play-store.


#### Implementing our workflow file

// TODO add workflow file here.



## 🍏 Apple `App Store`

Now that we know how to release our app in Google's `Play Store`,
it's time to go to the other side 
and get our app available to iPhone users!


### 0. Prerequisites

Similarly to before,
we need to make sure some prerequisites are fulfilled
in order to publish our app.

#### Install X-Code

If you don't already have `XCode` installed, 
open your `AppStore`, search for "XCode" and press `Install`. 
It's that easy.

<p align="center">
  <img width="800" src="https://user-images.githubusercontent.com/17494745/200554456-ff9dc9cb-7a2a-4eb8-aff4-90dfd00a0427.png" />
</p>


#### Ensure app adheres to the guidelines

You need to make sure the app follow's `App Store`'s guidelines.
If not, it *won't get published*.

You can check the guidelines in https://developer.apple.com/app-store/review/guidelines/.


#### Make sure you're enrolled in the `Apple Developer Program`

So you can publish apps, your Apple account
needs to be part of the `Apple Developer Program`.

Chances are you're already enrolled.
However, if you're not,
please visit https://developer.apple.com/programs/enroll/.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/287fcb4b-91a3-4b42-86d0-6edd13509376" />
</p>

Click on `Start Enrollment` and fill in your `Apple ID` account information.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/564e7dca-61f7-41bd-a84b-52c4fd81102b" />
</p>

After logging in with your account,
you will be prompted with the Apple Developer Agreement.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/595f8057-f5fa-49d1-9a22-9422e9e5901f" />
</p>

After agreeing,
you will be logged in into your Apple Developer account.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/788077d6-3efa-4380-a935-54eea07c18ba" />
</p>

Now click on `Enroll Now`.
You will be shown the option 
to adhere to the Apple Developer Program
through their app or through the web.
In our case, let's choose the latter.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/65af8fda-83e6-492b-80d5-98471261095c" />
</p>

You'll have to go through filling your information,
selecting the entity type (whether you're an individual or an organization)
and agree to the legal terms.

<p align="center">
  <img width="33%" src="https://github.com/dwyl/app/assets/17494745/d86d96cd-3ed2-48ba-969e-7d088e3a9039" />
  <img width="33%" src="https://github.com/dwyl/app/assets/17494745/8d209125-d87f-4f84-ac43-b49d54ea8228" />
  <img width="33%" src="https://github.com/dwyl/app/assets/17494745/877c6e87-5d18-4ec5-abe0-f8858e669a20" />
</p>

After doing those, you'll need to pay a fee,
which you can renew annually or not.

<p align="center">
  <img width="800" src="https://github.com/dwyl/app/assets/17494745/49480655-819b-4c0d-8576-fbc64c0f0e90" />
</p>

After completing this purchase,
you'll be ready to start publishing your own applications 
in the Apple ecosystem! 

Great job! 👏