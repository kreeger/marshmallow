# Marshmallow

The state of Campfire clients on iOS kinda sucks. There's the official client, which is the only viable option, but it's iPhone only. There's Sparks, which is broken (has been for a really long time). And that's literally it.

Now that I know the name of the game (and the game is Cocoa Touch), I'm writing my own damn client.

## Introducing...

It's a lofty list but here's what it'll eventually support:

- 37signals OAuth2 implementation
- Multiple Campfire accounts
- Any kind of file uploads
- Universal binary

The "duh" list:

- Multiple rooms
- User lists
- Transcripts
- Image uploads

And the one thing it won't support (at least for a super long time):

- Push notifications

Seriously, that one is kind of a big deal, but it would require moving all this processing to a server that constantly listens to thousands of rooms and I don't have that kind of money or patience.

Speaking of money, it's gonna be a free app, with an in-app upgrade to pro. The pro upgrade will unlock fancy things like transcript search, any-kind-of-file uploads, and maybe a few other badass features I can think of. But since it's my first major own-released app, I want to make a majority of the features free to spur interest.

## In the open

That brings me to my next point. To spur more interest and to earn myself some serious nerd cred, I'm developing this baby as open-source. Seriously, if you're a developer, you're always free to download the source code and deploy it to your own devices using Xcode.

In addition, I'm making my [Trello board public][1] so you can comment and vote on features and implementation stuff. Commenting is locked for now, but once I get closer to publishing betas, I'll open it up for the world.

## Questions?

Hit me up [on Twitter][2], or more preferably [on App.net][3].

[1]:    https://trello.com/board/marshmallow/514fbcd0177fbc7739000041
[2]:    http://twitter.com/kreeger
[3]:    http://alpha.app.net/kreeger
