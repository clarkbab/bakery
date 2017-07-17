# Bakery

This application loads in a customer's order and determines the packs of baked goods that should be supplied to fulfill the order. 

When multiple combinations of packs can fulfill the order, the algorithm preferentially selects those with a larger quantity. This minimises the number of packs that need to be shipped.

This is a variation of the [Knapsack Problem](https://en.wikipedia.org/wiki/Knapsack_problem). In this case, the weights are the quantities in each pack and the total weight is set as the ordered quantity. Values aren't specified but we know that packs with larger quantities are preferred, thus these have a higher value/weight ratio.

## Environments

This project was tested on Ubuntu 16.04 and Mac OS X.

## System Dependencies

This application requires [Ruby](https://www.ruby-lang.org/) 2.4.1

Check your ruby version by running:

```
$ ruby -v
```

It is recommended to use a Ruby version manager such as RVM for managing Ruby versions. For information on RVM visit: https://rvm.io/rvm/install

```
$ rvm install 2.4.1
```

If already installed, you can switch versions using:

```
$ rvm use 2.4.1
```

Otherwise, to install Ruby visit: http://rubyinstaller.org/.

## Installation

Clone the repository:

```
$ git clone https://github.com/clarkbab/bakery.git
$ cd bakery
$ gem install bundler
$ bundle install
```

## Running

To run the project you must provide a filepath that points to a valid order text file. Order text files should have the desired quantity and the code of the product separated by whitespace:

```
10 VS5
14 MB11
13 CF
```

Run the project with:

```
$ ./run samples/order.txt
```

You should see the following output:

```
10 VS5 $17.98
  2 x 5 $8.99
14 MB11 $54.80
  1 x 8 $24.95
  3 x 2 $9.95
13 CF $25.85
  2 x 5 $9.95
  1 x 3 $5.95
```

## Development

The testing in this project is carried out using [RSpec](http://rspec.info/). Style guidelines and recommendations are taken from [Better Specs](http://www.betterspecs.org/).

To run the test suite:

```
$ rspec
```

This project is developed using the [ruby-style-guide](https://github.com/bbatsov/ruby-style-guide). The [RuboCop](https://github.com/bbatsov/rubocop) gem helps to enforce this style.

To run rubocop against the code base run:

```
$ rubocop
```

As recommended in the ruby-style-guide, the project follows the [rdoc](https://github.com/rdoc/rdoc) comment style.

To generate the documentation run:

```
$ rdoc --all --main README.md
```

To view the docs via browser:

```
$ ruby -run -e httpd doc -p 8080
```

## Licence

This project, bakery, is licensed under the GNU Lesser General Public Licence.
