# Obfuscated Identifier

Hide your Rails primary key without the need for token generation and additional index space.

Obfuscate Identifier uses an obfuscation algorithm to generate a unique identifier for your
existing primary key. As long as you have the key that was used to create the identifier then you
can get back to the original primary key.

This removes the need for tricks like generating a random number and storing indexing it as the
primary key is still used to retrieve the object.

There are a huge number of options when creating a system like this here are some of the
considerations whilst creating this gem:

  * Identifiers must be unique
  * Identifiers must be reversible
  * Identifiers should be consistent, repeat generation should create the same output
  * Patterns within identifiers should not be 'obvious' (sequences should be avoided)
  * The algorithm should not be overly complex
  * The algorithm should 'relatively' computationally inexpensive

### Notes:

Obfuscation is not encryption. It's important to note that this isn't really hiding anything,
if someone really wants to work out your primary key they probably can. This favors simplicity over
the quality of the identifier generated.

This was a very quick stab at an implementation. Pull requests and comments are hugely appreciated!

## Installation

Add this line to your application's Gemfile:

    gem 'obfusicated_identifier'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install obfusicated_identifier

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
