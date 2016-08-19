## NAME

leanpub - access the Leanpub web API

## VERSION

This document refers to leanpub version 0.3

## USAGE

    leanpub [options] command [command options]

## OPTIONS

- **-api\_key=key**

    Provide the Leanpub API key to be used for all actions.

- **-help**

    Print a brief help message and exit.

- **-manual**

    Print the manual page and exit.

- **-really**

    State that you really intend to do the command (e.g. publish).

- **-slug=your\_book**

    Provide the book's slug.

- **-version**

    Print $WebService::Leanpub::VERSION and exit.

## COMMANDS

- summary

    Get information about the book.

- job\_status

    Retrieve the status of the last job.

- partial\_preview

    Start a partial preview of your book using Subset.txt.

- subset

    Start a partial preview of your book using Subset.txt.

- preview

    Start a preview of your book.

- single filename

    Create a preview from a single file.

- publish \[ options \]

    Publish your book.

    You have to use option **-really** with this command.

    This command takes the following command options:

    - -email\_readers

        Email readers, notifying them that the book has been updated.

    - -release\_notes=notes

        The release notes to be included in the email to the readers.

- sales\_data

    Retrieve a summary of sales data.

- individual\_purchases \[ -page=p \]

    Retrieve data about individual purchases.

    This command takes the option `-page` to set the page of the individual
    purchases report to be retrieved.

- coupons options

    Get a list of coupons available for the book.

- create\_coupon

    Create a new coupon for your book.

    This function takes the following command options:

    - -coupon\_code=code

        Required.
        The coupon code for this coupon. This must be unique for the book.

    - -discounted\_price=price

        Required.
        The amount the reader will pay when using the coupon.

    - -start\_date=YYYY-MM-DD

        Required.
        The date the coupon is valid from.

    - -end\_date=YYYY-MM-DD

        The date the coupon is valid until.

    - -has\_uses\_limit

        Whether or not the coupon has a uses limit.

    - -max\_uses=uses

        The max number of uses available for a coupon. An integer.

    - -note=note\_for\_me

        A description of the coupon. This is just used to remind you of what it was
        for.

    - -suspended

        Whether or not the coupon is suspended.

- update\_coupon options

    Update a coupon.

    This command takes the same argumentes as create\_coupon but only the option
    \--coupon\_code is required, all others are optional.

## DESCRIPTION

This program interacts with the Leanpub API.
You can find details about this API at [https://leanpub.com/help/api](https://leanpub.com/help/api).

The slug is the part of the URL for your book coming
after `https://leanpub.com/`. For instance if your book is found at
`https://leanpub.com/your_book`, then the slug for your book is
_your\_book_.

## FILES

### CONFIGURATION

This program searches in the current working directory and all directories
above for a text file named _.leanpub.conf_. It reads these files
and adds configuration directives which are not set so far to its
configuration.

The format of the file is rather simple. It is just a key and a value separated
by an equal sign and optional whitespace. Valid keys are the names of the
global options without any minus or plus sign. For instance I have a file
containing something like:

    # configuration for leanpub
    #
    api_key = my_api_key_from_leanpub
    slug    = using-the-leanpub-api-with-perl

in the directory I am developing this module in. So I don't have to provide
the options `-api_key` and `-slug` to test this script. When I use
the script for more than one book, I place a file called _.leanpub.conf_
containing the API key further up and have only the SLUG in the files located
in the book directories. To use a different API key I would write it in the
file in the book directory so that the one further up would not be used.

## AUTHOR

Mathias Weidner
