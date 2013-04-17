# Developing on Marshmallow

If you're wanting to download this code and run it on your own device, there are a few things you'll need to do first.

## Run the opinionated bootstrap script

From the root of the project directory.

``` bash
$ ./setup-env.rb
```

This does the following (you can run each process by hand if you're doing things "your own way"):

1. Ensures you're running with all the latest gems required by this project
2. Same with the necessary CocoaPods
3. Installs `mogenerator` and `appledoc` using Homebrew
4. Builds out the appledoc documentation sets.
5. Copies in the fonts from your Mac's Fonts directory (in order to keep this repository free of unnecessary font files, since all Macs will have the fonts used in the app)
6. Copies over the placeholder `APIKeys.plist.example` file as `APIKeys.plist`

## Setup your OAuth keys

Put them in `Resources/APIKeys.plist`. This file is excluded from the repo for security reasons.
