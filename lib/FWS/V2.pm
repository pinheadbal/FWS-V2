package FWS::V2;

use 5.006;
use strict;


#
# not everything will be defined by nature
#
no warnings 'uninitialized';


=head1 NAME

FWS::V2 - Framework Sites version 2

=head1 VERSION

Version 0.009

=cut

our $VERSION = '0.009';


=head1 SYNOPSIS

    use FWS::V2;
    my $fws = FWS::V2->new(	DBName		=> 'myDB',
				DBUser		=> 'theUser',
				DBPassword	=> 'superSecret',
				DBHost		=> 'localhost',
				DBType		=> 'MySQL');

=cut
	
=head1 DESCRIPTION

FWS::V2 is the utility counterpart to the web based content management development platform provided at www.frameworksites.com.  The web based version of this module is derived from this source with additional web specific features and packaging.   The web based version enables the FWS to function on most any modern hosting environment, be upgraded in real time via the web based FWS administration, and control shared plugins between all of your installations even on different servers.

Using this version is ideal for accessing any plugin feature, or data stored within a FWS installation from a standalone script.  Examples of this would be scripts to do site maintenance, imports, exports, mass data updates, data mining, 3rd party data synchronization, web services, APIs... and more!   

The syntax and usage of the FWS::V2 is identical to the web based element and plugin development available within the FWS web based administration.  Code from either is interchangeable between both distributions of FWS::V2 and the web based distribution of FWS available from www.frameworksites.com.

=head1 METHODS AND PARAMETERS

=head2 new

Construct a FWS version 2 object. Like the highly compatible web optimized distribution this will initiate access to all the FWS methods to access data, file, session, formatting and network methods. You can pass a variety of different parameters which could be required depending on what methods you are using and the context of your usage. MySQL and SQLite are supported with FWS 2, but MySQL should always be used if it is available. On medium or high traffic sites and sites with any significance of a data footprint, you will see quite a bit of latency with SQLite. 

Example of using FWS with MySQL:

        #
        # Create FWS with MySQL connectivity
        #
	use FWS::V2;
        my $fws = FWS::V2->new(       DBName          => "theDBName",
                                      DBUser          => "myUser",
                                      DBPassword      => "myPass");

Example of using FWS with SQLite:

        #
        # create FWS with SQLite connectivity
        #
	use FWS::V2;
        my $fws = FWS::V2->new(      DBType          => "SQLite",
                                     DBName          => "/home/user/your.db");

Any variable passed or derived can be accessed with the following syntax:

	print $fws->{'someParameter'}."\n";

With common uses of FWS, you should never need to change any of these settings.  If for some reason, although it is NOT recommended you can set any of these variables with the following syntax:

	$fws->{'someParameter'} = 'new settings';

=head2 Required Parameters

=over 4

=item * DBName (MySQL and SQLite Required)

For MySQL this is the DB Name.  For SQLite this is the DB file path and file name.
MySQL example:  user_fws
SQLite example: /home/user/secureFiles/user_fws.db

=item * DBUser (MySQL Required)

Required for MySQL and is the database user that has full grant access to the database.

=item * DBPassword (MySQL Required)

The DBUser's password.

=item * DBHost (MySQL Required if your database is not on localhost)

The DBHost will default to 'localhost' if not specified, but can be what ever is configured for the database environment.

=item * DBType (SQLite Required)

The DBType will default to 'MySQL' if not specified, but needs to be added if you are connecting to SQLite.

=back

=head2 Non-Required Parameters

Non-required parameters for FWS installations can be added, but depending on the scope of your task they usually are not needed unless your testing code, or interacting with web elements that display rendered content from a stand alone script.

=over 4

=item * adminPassword

For new installations this is the admin password until the first super admin account is created.  After an admin account is created this password is disabled.

=item * adminURL

The url defined to get to the typical /admin log in screen.  Default: 'admin'

=item * affiliateExpMax

The number of seconds an affiliate code will stay active after it has been received.  Default: 295200

=item * cookieDomainName

The domain to use for cookies.  Almost always it would be: '.whatEverYourDomainIs.com'  For more complex scenario with host names you would want to make this more specific.

=item * domain

Full domain name with http prefix.  Example: http://www.example.com

=item * encryptionKey

The encryption key to be used if encryptionType is set to 'blowfish'.

=item * encryptionType

If set this will set what encryption method to use on sensitive data.  The only supported type is 'blowfish'.

=item * filePath

Full path name of common files. Example: /home/user/www/files

=item * fileSecurePath

Full path name of non web accessible files. Example: /home/user/secureFiles

=item * fileWebPath

Web path for the same place filePath points to.  Example: /files

=item * googleAppsKeyFile

For google apps support for standard login modules this is required

=item * hideEditModeHeaders

Turn off all blue bar column headers for a site.  (Suppress the adding of elements to pages on a UI standpoint)

=item * scriptTextSize

If your element scripts are larger than 'text' and get truncated you might want to set this to 'mediumtext'

=item * secureDomain

Secure domain name with https prefix. For non-secure sites that do not have an SSL cert you can use the http:// prefix to disable SSL.  Example: https://www.example.com

=item * sendmailBin

The location of the sendmail bin. Default: /usr/sbin/sendmail

=item * sendMethod

The method used to process queue requests internal or custom.   Default: sendmail

=item * sessionCookieName

If there could be conflict with the cookie name, you can change the name of the cookie from its default of fws_session to something else.

=item * FWSLogLevel

Set how verbose logging is for FWS is.  Logging will be appended: $fws->{'fileSecurePath'}.'/FWS.log'
0 - off , 1 (default)- Display errors

=item * FWSKey

This is the domain key from your frameworksites.com account. This is used to share content from different installs using frameworksites.com as your distribution hub.  This is only used if your a FWS plugin developer or a developer has given you this key to install a plugin they created. 

=item * FWSPluginServer

The server used to plublish and intall plugins.  Defaults to https://www.frameworksites.com

=item * FWSServer

The server used to download the FWS Core updates.  Defaults to http://www.frameworksites.com

=item * SQLLogLevel

Set how verbose logging is for SQL statements ran.  Logging will be appended: $fws->{'fileSecurePath'}.'/SQL.log'
0 - off (default), 1 - updates/deletes/inserts only, 2 - everything (This file will grow fast if set to 2)

=back

=head1 DERIVED VARIABLES AND METHODS

=head2 Accessable after getFormValues() is called

=over 4

=item * formValue()

All passed variables.  The value is not set, it will return as blank.

=item * formArray()

An array of form values passed.

=back

=head2 Accessable after setSiteFiendly() is called

=over 4

=item * {'siteId'}

The site id of the site currently being rendered.  Version 1 of FWS refered to this as the SID.  This will be set via setSiteValues('yourSiteId') if setSiteFriendly is not being used.

=item * formValue('p')

The current page friendly or if not available the page guid.

=back 

=head2 Accessable after setSession() is called

=over 4

=item * {'affiliateId'}

Is set by passing a value to 'a' as a form value. Can be accessed via $fws->{'affiliateId'}

=item * {'affiliateExp'}

The time in epoch that the affiliate code will expire for the current session.

=item * formValue('session')

The current session ID.

=back

=head2 Accessable after setSiteValues() is called

=over 4

=item * {'email'}

The default email address for the site being rendered.  This is set via 'Site Settings' in the administration.

=item * {'fileFWSPath'}

The file location of FWS packaged distribution files.  This is normaly not used except internally as the files in this directory could change with an upgrade.

=item * {'homeGUID'}

The guid of the home page.  The formValue 'p' will be set to this if no 'p' value is passed.

=item * {'siteGUID'}

The guid of the site currently being rendered.

=item * {'siteName'}

The site name of the site currently being rendered.

=item * {'queryHead'}

The query head used for links that will maintain session and have a unique random cache key.  Example return: ?fws_noCache=asdqwe&session=abc....123&s=site&  It is important not to use this in a web rendering that will become static though caching.   If the session= is cached on a static page it will cause a user who clicks the cached link to be logged out.  queryHead is only to ment to be used in situations when you are passing from one domain to another and wish to maintain the same session ID.

=back

=head2 Accessable after processLogin() is called

=over 4

=item * {'adminLoginId'}

The current user id for the admin user logged in.  Extra warning: This should never be set externally!

=item * {'userLoginId'}

The current user id for the site user logged in.  Extra warning: This should never be set externally!

=back

=cut

#########################################################################
#
#                      CODING AND STYLE HINTS
#
#            If you going to touch the code,  read this first!
#
#########################################################################
#
# WEB OPTIMIZED COMPATABILITY VERSION
# The compatability version of this code base is derived from these
# modules and in a couple spots you will see a HIDE and END HIDE
# block which is used by the compatability processor.  Leave these
# in tact to maintain compatability with that processor.
#
# INHERITANCE
# The compatibility version of this code has one package.  To maintain
# consistancy between the two versions everything is inherited, always.
#
# ELSE CUDDLING
# Use non cuddled elses unless its all on the same line with the if. 
#
# CONDITIONALS PERFER 'ne' 'eq'
# All conditionals that can be, are treated like strings and in very 
# limited cases is 'exists', and 'defined' used.  This is due to the
# anonymous hash structure and creating consistant logic for hashes
# that might not yet be defined depending on scope.
#
# HASH ARRAYS (An array of hashes)
# If your unfamiliar wit this technique read up on it.  The data model
# for FWS is based on the idea of arrays of anonymous hashes.  It is
# everywhere you get data!
#
# REFERENCES
# The original version of FWS did not use extensive references for data
# in an attempt to make things simple.  By default hash arrays will come
# back in this way unless you specify ref=>1 in the whateverArray or 
# whateverHash call.  In future versions this will be reversed so doing
# ref=>1 in all calls hash/Array methods would be considered good form. 
#
# LEGACY GET/SET SUBROUTINES
# A lot of get/set type functions were also in the original source
# those are getting phased out to only use the $fws->{'theSetting'} = '1'
# syntax.   Make note of the legacy functions in the POD and use the
# more current syntax when available#
#
#########################################################################

################## HIDE ##################### Web optimized import block flag
BEGIN {
        our @ISA = (	"FWS::V2::Database",
                        "FWS::V2::Check",
                        "FWS::V2::File",
                        "FWS::V2::Format",
                        "FWS::V2::Net",
                        "FWS::V2::Legacy",
                        "FWS::V2::Session",
                        "FWS::V2::Safety");
   
	use FWS::V2::Database;
	use FWS::V2::Check;
	use FWS::V2::File;
	use FWS::V2::Format;
	use FWS::V2::Net;
	use FWS::V2::Legacy;
	use FWS::V2::Session;
	use FWS::V2::Safety;
}

sub new {
	my ($class, %params) = @_;
	my $self = bless \%params, $class;

        #
        # set the FWS version we are using
        #
        $self->{'FWSVersion'} = '2.1.0';

        #
        # Major version parse
        #
        my @loadVerSplit = split(/\./,$self->{'FWSVersion'});
        $self->{'FWSMajorVersion'} = $loadVerSplit[0].'.'.$loadVerSplit[1];

        #
        # fake common ENV vars if we don't have them
        #
        if (!exists $ENV{"REMOTE_ADDR"}) { $ENV{"REMOTE_ADDR"}  = 'localhost' }
        if (!exists $ENV{"SERVER_NAME"}) { $ENV{"SERVER_NAME"}  = 'localhost' }
        if (!exists $ENV{"REQUEST_URI"}) { $ENV{"REQUEST_URI"}  = '' }


        #
        # set the default security hash
        #
        $self->{'securityHash'}->{'isAdmin'}{'title'}           = 'Super User Account';
        $self->{'securityHash'}->{'isAdmin'}{'note'}            = 'This user has access to all FWS features, and has the ability to add and remove admin users.  All installations should have one user of this type for security reasons.  Having a user of this type will disable the embedded admin account.';

        $self->{'securityHash'}->{'showContent'}{'title'}       = 'Full Edit Mode Access';
        $self->{'securityHash'}->{'showContent'}{'note'}        = 'Access to view and change the content in edit mode.';

        $self->{'securityHash'}->{'showDesign'}{'title'}        = 'Designer Access';
        $self->{'securityHash'}->{'showDesign'}{'note'}         = 'Add and delete pages, layouts, design css, javascript, and files.';

        $self->{'securityHash'}->{'showDeveloper'}{'title'}     = 'Developer Access';
        $self->{'securityHash'}->{'showDeveloper'}{'note'}      = 'Access to developer controls, element custom element creation and site creation and deletion.';

        $self->{'securityHash'}->{'showQueue'}{'title'}         = 'Email Queue Access';
        $self->{'securityHash'}->{'showQueue'}{'note'}          = 'Access to view email sending queue, and message history.';

        $self->{'securityHash'}->{'showSEO'}{'title'}           = 'SEO Controls';
        $self->{'securityHash'}->{'showSEO'}{'note'}            = 'Access to view SEO Defaults and page properties.';

        $self->{'securityHash'}->{'showSiteSettings'}{'title'}  = 'Site Settings Menu';
        $self->{'securityHash'}->{'showSiteSettings'}{'note'}   = 'Generic site settings and 3rd party connector configurations.';

        $self->{'securityHash'}->{'showSiteUsers'}{'title'}     = 'User Account Access';
        $self->{'securityHash'}->{'showSiteUsers'}{'note'}      = 'Access to create, delete and modify high level information for site accounts and groups.';


        # if the admin ID is blank, set it to admin so users can access it via /admin
	$self->{'adminURL'} 		= defined $self->{'adminURL'} 		? $self->{'adminURL'} 		: 'admin';

        # set the secure domain to a non https because it probably does not have a cert if it was not set
	$self->{'secureDomain'} 	= defined $self->{'secureDomain'}	? $self->{'secureDomain'} 	: 'http://'.$ENV{"SERVER_NAME"};

        # Change the theme of the ace IDE for developer mode
	$self->{'aceTheme'} 		= defined $self->{'aceTheme'}		? $self->{'aceTheme'} 		: 'idle_fingers';

        # The subdirectory of where tinyMCE is placed to make upgrading  and testing new versions easier
	$self->{'tinyMCEPath'} 		= defined $self->{'tinyMCEPath'}	? $self->{'tinyMCEPath'} 	: 'tinymce-3.5.4';

        # Sometimes sites need bigger thatn text blob, 'mediumtext' might be needed
	$self->{'scriptTextSize'} 	= defined $self->{'scriptTextSize'}	? $self->{'scriptTextSize'} 	: 'text';

        # set the domains to the environment version if it was not set
	$self->{'sessionCookieName'} 	= defined $self->{'sessionCookieName'}	? $self->{'sessionCookieName'} 	: 'fws_session';

        # set mysql to default
	$self->{'DBType'} 		= defined $self->{'DBType'}		? $self->{'DBType'} 		: 'mysql';
        
	# set mysql default port
	$self->{'DBPort'} 		= defined $self->{'DBPort'}		? $self->{'DBPort'} 		: '3306';

        # set the domains to the environment version if it was not set
	$self->{'domain'} 		= defined $self->{'domain'}		? $self->{'domain'} 		: 'http://'.$ENV{"SERVER_NAME"};

        # if the admin ID is blank, set it to admin so users can access it via /admin
	$self->{'FWSPluginServer'} 	= defined $self->{'FWSPluginServer'}	? $self->{'FWSPluginServer'} 	: 'https://www.frameworksites.com';
        
        # the FWS auto update server
	$self->{'FWSServer'} 		= defined $self->{'FWSServer'}		? $self->{'FWSServer'} 		: 'http://www.frameworksites.com/downloads';

        # set the default seconds to how long a affiliate code will last once it is recieved
	$self->{'affiliateExpMax'} 	= defined $self->{'affiliateExpMax'}	? $self->{'affiliateExpMax'} 	: 295200;

        # set the default FWS log level
	$self->{'FWSLogLevel'} 		= defined $self->{'FWSLogLevel'}	? $self->{'FWSLogLevel'} 	: 1;

        # set the default SQL log level
	$self->{'SQLLogLevel'} 		= defined $self->{'SQLLogLevel'}	? $self->{'SQLLogLevel'} 	: 0;

        # set the default location for sendmail
	$self->{'sendmailBin'} 		= defined $self->{'sendmailBin'}	? $self->{'sendmailBin'} 	: '/usr/sbin/sendmail';

        #
        # prepopulate a few things that might be needed so they are not undefined
        #
        %{$self->{'_cssHash'}}                  = ();
        %{$self->{'_jsHash'}}                   = ();
        %{$self->{'_jqueryHash'}}               = ();
        %{$self->{'_saveWithSessionHash'}}      = ();
        %{$self->{'_fullElementHashCache'}}     = ();
        %{$self->{'_tableFieldHashCache'}}      = ();
        %{$self->{'_siteScriptCache'}}          = ();
        %{$self->{'_subscriberCache'}}          = ();

        $self->{'_language'}                    = '';
        $self->{'_languageArray'}               = '';

	@{$self->{'pluginCSSArray'}}		= ();
	@{$self->{'pluginJSArray'}}		= ();
	
        #
        # cache fields will be populated on setSiteValues
        # but in case we need a ph before then
        #
        %{$self->{'dataCacheFields'}}           = ();
        %{$self->{'plugins'}}           	= ();

        #
        # this will store the currently logged in userHash
        #
        %{$self->{'profileHash'}}               = ();
        
	#
        # For plugin added, and cached elementHashes lets predefine this
        #
        %{$self->{'elementHash'}}               = ();


        #
        # set this to false, it might be turned on at any time by admin or elements
        #
        $self->{'tinyMCEEnable'}                = 0;


        #
        # core database schema
        #
        $self->{"dataSchema"}{"queue_history"} = {
                "guid"                          => { type => "char(36)" ,key => "MUL"         ,default => ""                  ,noSite => 1},
                "site_guid"                     => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "created_date"                  => { type => "datetime" ,key => ""            ,default => "0000-00-00"        },
                "queue_guid"                    => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "profile_guid"                  => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "directory_guid"                => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "type"                          => { type => "char(50)" ,key => "MUL"         ,default => ""                  },
                "queue_from"                    => { type => "char(255)",key => "MUL"         ,default => ""                  },
                "from_name"                     => { type => "char(255)",key => ""            ,default => ""                  },
                "queue_to"                      => { type => "char(255)",key => "MUL"         ,default => ""                  },
                "subject"                       => { type => "char(255)",key => ""            ,default => ""                  },
                "success"                       => { type => "int(1)"   ,key => ""            ,default => "0"                 },
                "synced"                        => { type => "int(1)"   ,key => ""            ,default => "0"                 },
                "body"                          => { type => "text"     ,key => ""            ,default => ""                  },
                "hash"                          => { type => "text"     ,key => ""            ,default => ""                  },
                "failure_code"                  => { type => "char(255)",key => ""            ,default => ""                  },
                "response"                      => { type => "char(255)",key => ""            ,default => ""                  },
                "sent_date"                     => { type => "datetime" ,key => ""            ,default => "0000-00-00 00:00:00"},
                "scheduled_date"                => { type => "datetime" ,key => ""            ,default => "0000-00-00 00:00:00"},
        };

        $self->{"dataSchema"}{"queue"} = {
                "guid"                          => { type => "char(36)" ,key => "MUL"         ,default => ""                  ,noSite => 1},
                "site_guid"                     => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "created_date"                  => { type => "datetime" ,key => ""            ,default => "0000-00-00"        },
                "profile_guid"                  => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "directory_guid"                => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "type"                          => { type => "char(50)" ,key => "MUL"         ,default => ""                  },
                "queue_from"                    => { type => "char(255)",key => "MUL"         ,default => ""                  ,AJAXGroup => 'showQueue'},
                "queue_to"                      => { type => "char(255)",key => "MUL"         ,default => ""                  ,AJAXGroup => 'showQueue'},
                "draft"                         => { type => "int(1)"   ,key => ""            ,default => "0"                 },
                "from_name"                     => { type => "char(255)",key => ""            ,default => ""                  ,AJAXGroup => 'showQueue'},
                "subject"                       => { type => "char(255)",key => ""            ,default => ""                  ,AJAXGroup => 'showQueue'},
                "mime_type"                     => { type => "char(100)",key => ""            ,default => ""                  ,AJAXGroup => 'showQueue'},
                "transfer_encoding"             => { type => "char(100)",key => ""            ,default => ""                  },
                "digital_assets"                => { type => "text"     ,key => ""            ,default => ""                  },
                "body"                          => { type => "text"     ,key => ""            ,default => ""                  ,AJAXGroup => 'showQueue'},
                "hash"                          => { type => "text"     ,key => ""            ,default => ""                  },
                "scheduled_date"                => { type => "datetime" ,key => ""            ,default => "0000-00-00 00:00:00",AJAXGroup => 'showQueue'},
        };

        $self->{"dataSchema"}{"events"} = {
                "site_guid"                     => { type => "char(36)" ,key => "MUL"         ,default => ""                  ,noSite => 1},
                "guid"                          => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "price"                         => { type => "double"   ,key => "MUL"         ,default => "0"                 },
                "profile_guid"                  => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "name"                          => { type => "char(255)",key => "FULLTEXT"    ,default => ""                  },
                "title"                         => { type => "char(255)",key => "FULLTEXT"    ,default => ""                  },
                "city"                          => { type => "char(255)",key => "MUL"         ,default => ""                  },
                "state"                         => { type => "char(255)",key => "MUL"         ,default => ""                  },
                "address"                       => { type => "char(255)",key => ""            ,default => ""                  },
                "address2"                      => { type => "char(255)",key => ""            ,default => ""                  },
                "zip"                           => { type => "char(255)",key => ""            ,default => ""                  },
                "location"                      => { type => "char(255)",key => ""            ,default => ""                  },
                "website"                       => { type => "char(255)",key => ""            ,default => ""                  },
                "phone"                         => { type => "char(255)",key => ""            ,default => ""                  },
                "date_from"                     => { type => "datetime" ,key => "MUL"         ,default => "0000-00-00"        },
                "date_to"                       => { type => "datetime" ,key => "MUL"         ,default => "0000-00-00"        },
                "created_date"                  => { type => "datetime" ,key => ""            ,default => "0000-00-00"        },
                "description"                   => { type => "text"     ,key => "FULLTEXT"    ,default => ""                  },
                "latitude"                      => { type => "float"    ,key => "MUL"         ,default => "0"                 },
                "longitude"                     => { type => "float"    ,key => "MUL"         ,default => "0"                 },
                "directory_guid"                => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "extra_value"                   => { type => "text"     ,key => ""            ,default => ""                  ,AJAXGroup => 'showEvents'},
        };

        $self->{"dataSchema"}{"history"} = {
                "site_guid"                     => { type => "char(36)" ,key => "MUL"         ,default => ""                  ,noSite => 1},
                "created_date"                  => { type => "datetime" ,key => ""            ,default => "0000-00-00"        },
                "guid"                          => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "type"                          => { type => "char(1)"  ,key => "MUL"         ,default => ""                  },
                "name"                          => { type => "char(255)",key => "FULLTEXT"    ,default => ""                  },
                "url"                           => { type => "char(255)",key => ""            ,default => ""                  },
                "title"                         => { type => "char(255)",key => "FULLTEXT"    ,default => ""                  },
                "latitude"                      => { type => "float"    ,key => "MUL"         ,default => "0"                 },
                "longitude"                     => { type => "float"    ,key => "MUL"         ,default => "0"                 },
                "hash"                          => { type => "text"     ,key => ""            ,default => ""                  },
                "description"                   => { type => "text"     ,key => "FULLTEXT"    ,default => ""                  },
                "referrer_guid"                 => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "directory_guid"                => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "profile_guid"                  => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
        };

        $self->{"dataSchema"}{"topic"} = {
                "site_guid"                     => { type => "char(36)" ,key => "MUL"         ,default => ""                  ,noSite => 1},
                "guid"                          => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "created_date"                  => { type => "datetime" ,key => ""            ,default => "0000-00-00"        },
                "name"                          => { type => "char(255)",key => "MUL"         ,default => ""                  },
                "title"                         => { type => "char(255)",key => "MUL"         ,default => ""                  },
                "tags"                          => { type => "char(255)",key => "MUL"         ,default => ""                  },
                "description"                   => { type => "text"     ,key => "FULLTEXT"    ,default => ""                  },
                "content"                       => { type => "text"     ,key => "FULLTEXT"    ,default => ""                  },
                "content_1"                     => { type => "text"     ,key => "FULLTEXT"    ,default => ""                  },
                "content_2"                     => { type => "text"     ,key => "FULLTEXT"    ,default => ""                  },
                "fb_content"                    => { type => "text"     ,key => "FULLTEXT"    ,default => ""                  },
                "twitter_content"               => { type => "text"     ,key => "FULLTEXT"    ,default => ""                  },
                "directory_guid"                => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "active"                        => { type => "int(1)"   ,key => "MUL"         ,default => "0"                 },
                "draft"                         => { type => "int(1)"   ,key => "MUL"         ,default => "0"                 },
                "url"                           => { type => "char(255)",key => ""            ,default => ""                  },
                "image_1"                       => { type => "char(255)",key => ""            ,default => ""                  },
                "date_to"                       => { type => "date",    ,key => "MUL"         ,default => "0000-00-00"        },
                "date_from"                     => { type => "date",    ,key => "MUL"         ,default => "0000-00-00"        },
                "extra_value"                   => { type => "text"     ,key => ""            ,default => ""                  },
        };

        $self->{"dataSchema"}{"auto"} = {
                "make"                          => { type => "char(255)",key => "MUL"         ,default => ""                  },
                "model"                         => { type => "char(255)",key => "MUL"         ,default => ""                  },
                "year"                          => { type => "char(4)"  ,key => "MUL"         ,default => ""                  },
        };

        $self->{"dataSchema"}{"country"} = {
                "name"                          => { type => "char(255)",key => ""            ,default => ""                  },
                "twoCharacter"                  => { type => "char(2)"  ,key => ""            ,default => ""                  },
                "threeCharacter"                => { type => "char(3)"  ,key => ""            ,default => ""                  },
        };

        $self->{"dataSchema"}{"zipcode"} = {
                "zipCode"                       => { type => "char(7)"  ,key => "MUL"         ,default => ""                  },
                "zipType"                       => { type => "char(1)"  ,key => ""            ,default => ""                  },
                "stateAbbr"                     => { type => "char(2)"  ,key => ""            ,default => ""                  },
                "city"                          => { type => "char(255)",key => "FULLTEXT"    ,default => ""                  },
                "areaCode"                      => { type => "char(3)"  ,key => ""            ,default => ""                  },
                "timeZone"                      => { type => "char(12)" ,key => ""            ,default => ""                  },
                "UTC"                           => { type => "int(10)"  ,key => ""            ,default => "0"                 },
                "DST"                           => { type => "char(1)"  ,key => ""            ,default => ""                  },
                "latitude"                      => { type => "float"    ,key => "MUL"         ,default => "0"                 },
                "longitude"                     => { type => "float"    ,key => "MUL"         ,default => "0"                 },
                "loc_id"                        => { type => "int(11)"  ,key => "MUL"         ,default => "0"                 },
        };

        $self->{"dataSchema"}{"geo_block"} = {
                "start_ip"                      => { type => "int(11)"  ,key => "MUL"         ,default => "0"                 },
                "end_ip"                        => { type => "int(11)"  ,key => "MUL"         ,default => "0"                 },
                "loc_id"                        => { type => "int(11)"  ,key => "MUL"         ,default => "0"                 },
        };

        $self->{"dataSchema"}{"templates"} = {
                "site_guid"                     => { type => "char(36)" ,key => "MUL"         ,default => ""                  ,noSite => 1},
                "guid"                          => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "title"                         => { type => "char(255)",key => ""            ,default => ""                  ,AJAXGroup => 'showDesign'},
                "default_template"              => { type => "int(1)"   ,key => ""            ,default => "0"                 },
                "template_devel"                => { type => "text"     ,key => ""            ,default => ""                  },
                "css_devel"                     => { type => "int(1)"   ,key => ""            ,default => "0"                 },
                "js_devel"                      => { type => "int(1)"   ,key => ""            ,default => "0"                 },
        };

        $self->{"dataSchema"}{"data_cache"} = {
                "site_guid"                     => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "guid"                          => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "name"                          => { type => "char(255)",key => "FULLTEXT"    ,default => ""                  },
                "title"                         => { type => "char(255)",key => "FULLTEXT"    ,default => ""                  },
                "pageIdOfElement"               => { type => "char(36)" ,key => ""            ,default => ""                  },
                "pageDescription"               => { type => "text"     ,key => "FULLTEXT"    ,default => ""                  },
        };

        $self->{"dataSchema"}{"data"} = {
                "site_guid"                     => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "guid"                          => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "name"                          => { type => "char(255)",key => ""            ,default => ""                  ,AJAXGroup => 'showDeveloper|showContent|showDesign'},
                "title"                         => { type => "char(255)",key => "MUL"         ,default => ""                  ,AJAXGroup => 'showDeveloper|showContent|showDesign'},
                "nav_name"                      => { type => "char(255)",key => ""            ,default => ""                  ,AJAXGroup => 'showDeveloper|showContent|showDesign'},
                "active"                        => { type => "int(1)"   ,key => "MUL"         ,default => "0"                 ,AJAXGroup => 'showDeveloper|showContent|showDesign'},
                "lang"                          => { type => "char(2)"  ,key => "MUL"         ,default => ""                  ,AJAXGroup => 'showDeveloper|showContent|showDesign'},
                "disable_title"                 => { type => "int(1)"   ,key => "MUL"         ,default => "0"                 ,AJAXGroup => 'showDeveloper|showContent|showDesign'},
                "element_type"                  => { type => "char(50)" ,key => "MUL"         ,default => ""                  },
                "groups_guid"                   => { type => "char(36)" ,key => ""            ,default => ""                  ,AJAXGroup => 'showDeveloper|showContent|showDesign'},
                "created_date"                  => { type => "datetime" ,key => ""            ,default => "0000-00-00"        },
                "disable_edit_mode"             => { type => "int(1)"   ,key => ""            ,default => "0"                 ,AJAXGroup => 'showDeveloper|showContent|showDesign'},
                "default_element"               => { type => "int(2)"   ,key => ""            ,default => "0"                 ,AJAXGroup => 'showDeveloper|showContent|showDesign'},
                "show_login"                    => { type => "int(1)"   ,key => ""            ,default => "1"                 ,AJAXGroup => 'showDeveloper|showContent|showDesign'},
 		"show_mobile"                   => { type => "int(2)"   ,key => ""            ,default => "0"                 ,AJAXGroup => 'showDeveloper|showContent|showDesign'},
                "show_resubscribe"              => { type => "int(1)"   ,key => ""            ,default => "1"                 ,AJAXGroup => 'showDeveloper|showContent|showDesign'},
                "friendly_url"                  => { type => "char(255)",key => "MUL"         ,default => ""                  ,AJAXGroup => 'showDeveloper|showContent|showDesign'},
		"page_friendly_url"             => { type => "char(255)",key => "MUL"         ,default => ""                  ,AJAXGroup => 'showDeveloper|showContent|showDesign'},
                "extra_value"                   => { type => "text"     ,key => ""            ,default => ""                  ,AJAXGroup => 'showDeveloper|showContent|showDesign'},
        };

        $self->{"dataSchema"}{"admin_user"} = {
                "site_guid"                     => { type => "char(36)" ,key => "MUL"         ,default => ""                  ,noSite => 1},
                "guid"                          => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "user_id"                       => { type => "char(50)" ,key => "MUL"         ,default => ""                  },
                "name"                          => { type => "char(255)",key => ""            ,default => ""                  ,AJAXGroup => 'isAdmin'},
                "email"                         => { type => "char(255)",key => ""            ,default => ""                  ,AJAXGroup => 'isAdmin'},
                "admin_user_password"           => { type => "char(50)" ,key => "MUL"         ,default => ""                  ,cryptPassword => 1},
                "active"                        => { type => "int(1)"   ,key => "MUL"         ,default => "1"                 },
                "extra_value"                   => { type => "text"     ,key => ""            ,default => ""                  ,AJAXGroup => 'isAdmin'},
        };

        $self->{"dataSchema"}{"profile_groups_xref"} = {
                "site_guid"                     => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "profile_guid"                  => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "groups_guid"                   => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
        };

        $self->{"dataSchema"}{"profile"} = {
                "site_guid"                     => { type => "char(36)" ,key => "MUL"         ,default => ""                  ,noSite => 1},
                "guid"                          => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "pin"                           => { type => "char(6)"  ,key => "MUL"         ,default => ""                  },
                "profile_password"              => { type => "char(255)",key => ""            ,default => ""                  ,AJAXGroup => 'showSiteUsers',cryptPassword => 1},
                "fb_access_token"               => { type => "char(255)",key => ""            ,default => ""                  },
                "fb_id"                         => { type => "char(255)",key => ""            ,default => ""                  },
                "email"                         => { type => "char(255)",key => "MUL"         ,default => ""                  },
                "name"                          => { type => "char(255)",key => ""            ,default => ""                  ,AJAXGroup => 'showSiteUsers'},
                "active"                        => { type => "int(1)"   ,key => ""            ,default => "1"                 ,AJAXGroup => 'showSiteUsers'},
                "google_id"                     => { type => "char(255)",key => ""            ,default => ""                  ,AJAXGroup => 'showSiteUsers'},
                "extra_value"                   => { type => "text"     ,key => ""            ,default => ""                  ,AJAXGroup => 'showSiteUsers'},
        };

        $self->{"dataSchema"}{"fws_sessions"} = {
                "site_guid"                     => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "ip"                            => { type => "char(50)" ,key => "MUL"         ,default => ""                  },
		"fws_lang"                      => { type => "char(2)"  ,key => ""            ,default => ""                  },
                "b"                             => { type => "char(255)",key => ""            ,default => ""                  },
                "l"                             => { type => "char(50)" ,key => ""            ,default => ""                  },
                "bs"                            => { type => "char(50)" ,key => ""            ,default => ""                  },
                "e"                             => { type => "int(1)"   ,key => ""            ,default => "0"                 },
                "s"                             => { type => "int(1)"   ,key => ""            ,default => "0"                 },
                "a"                             => { type => "char(50)" ,key => ""            ,default => ""                  },
                "a_exp"                         => { type => "int(11)"  ,key => ""            ,default => "0"                 },
                "extra"                         => { type => "text"     ,key => ""            ,default => ""                  },
                "created"                       => { type => "timestamp",key => ""            ,default => "CURRENT_TIMESTAMP" },
        };

        $self->{"dataSchema"}{"guid_xref"} = {
                "site_guid"                     => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "child"                         => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "parent"                        => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "ord"                           => { type => "int(11)"  ,key => "MUL"         ,default => "0"                 },
                "layout"                        => { type => "char(50)" ,key => "MUL"         ,default => ""                  },
        };

        $self->{"dataSchema"}{"element"} = {
                "site_guid"                     => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "guid"                          => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "type"                          => { type => "char(50)" ,key => "MUL"         ,default => ""                  ,AJAXGroup => 'showDeveloper'},
                "parent"                        => { type => "char(36)" ,key => "MUL"         ,default => ""                  ,AJAXGroup => 'showDeveloper'},
                "title"                         => { type => "char(255)",key => ""            ,default => ""                  ,AJAXGroup => 'showDeveloper'},
                "tags"                          => { type => "char(255)",key => ""            ,default => ""                  ,AJAXGroup => 'showDeveloper'},
                "class_prefix"                  => { type => "char(255)",key => ""            ,default => ""                  ,AJAXGroup => 'showDeveloper'},
                "admin_group"                   => { type => "char(50)" ,key => ""            ,default => ""                  ,AJAXGroup => 'showDeveloper'},
                "ord"                           => { type => "int(11)"  ,key => "MUL"         ,default => "0"                 ,AJAXGroup => 'showDeveloper'},
                "public"                        => { type => "int(1)"   ,key => ""            ,default => "0"                 ,AJAXGroup => 'showDeveloper'},
                "css_devel"                     => { type => "int(1)"   ,key => ""            ,default => "0"                 },
                "js_devel"                      => { type => "int(1)"   ,key => ""            ,default => "0"                 },
                "script_devel"                  => { type => $self->{'scriptTextSize'},key=>"",default => ""                  },
                "schema_devel"                  => { type => "text"     ,key => ""            ,default => ""                  },
                "active"                        => { type => "int(1)"   ,key => ""            ,default => "0"                 },
                "checkedout"                    => { type => "int(1)"   ,key => ""            ,default => "0"                 },
                "root_element"                  => { type => "int(1)"   ,key => ""            ,default => "0"                 ,AJAXGroup => 'showDeveloper'},
        };

        $self->{"dataSchema"}{"groups"} = {
                "site_guid"                     => { type => "char(36)" ,key => "MUL"         ,default => ""                  ,noSite => 1},
                "guid"                          => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "name"                          => { type => "char(50)" ,key => ""            ,default => ""                  ,AJAXGroup => 'showSiteUsers'},
                "description"                   => { type => "char(255)",key => ""            ,default => ""                  ,AJAXGroup => 'showSiteUsers'},
        };

        $self->{"dataSchema"}{"site"} = {
                "site_guid"                     => { type => "char(36)" ,key => ""            ,default => ""                  ,noSite => 1},
                "guid"                          => { type => "char(36)" ,key => "MUL"         ,default => ""                  },
                "email"                         => { type => "char(255)",key => ""            ,default => ""                  ,AJAXGroup => 'showSiteSettings'},
                "name"                          => { type => "char(255)",key => ""            ,default => ""                  ,AJAXGroup => 'showSiteSettings'},
                "language_array"                => { type => "char(255)",key => ""            ,default => ""                  ,AJAXGroup => 'showSiteSettings'},
                "sid"                           => { type => "char(50)" ,key => "MUL"         ,default => ""                  },
                "created_date"                  => { type => "datetime" ,key => ""            ,default => "0000-00-00"        },
                "gateway_type"                  => { type => "char(10)" ,key => ""            ,default => ""                  ,AJAXGroup => 'showSiteSettings'},
                "gateway_user_id"               => { type => "char(150)",key => ""            ,default => ""                  ,AJAXGroup => 'showSiteSettings'},
                "gateway_password"              => { type => "char(150)",key => ""            ,default => ""                  ,AJAXGroup => 'showSiteSettings', encrypt=> 1},
                "home_guid"                     => { type => "char(36)" ,key => ""            ,default => ""                  },
                "js_devel"                      => { type => "int(1)"   ,key => ""            ,default => "0"                 },
                "css_devel"                     => { type => "int(1)"   ,key => ""            ,default => "0"                 },
                "default_site"                  => { type => "int(1)"   ,key => ""            ,default => "0"                 },
                "extra_value"                   => { type => "text"     ,key => ""            ,default => ""                  ,AJAXGroup => 'showSiteSettings'},
        };

        return $self;
}


############### END HIDE #################### Web optimized import block flag

=head1 FWS PLUGINS

=head2 registerPlugin

If server wide plugins are being added for this instance they will be under the FWS::V2 Namespace, if not they can be added just as the plugin name.

	#
	# register plugins that are available server wide 
	#
        $fws->registerPlugin('FWS::V2::SomePlugin');
	
	#
	# register some plugin added via the FWS 2.1 Plugin manager
        #
	$fws->registerPlugin('somePlugin');

Additionally if you want to check if a plugin is active inside of element or scripts you can use the following conditional:

	#
	# check to see if ECommerce is loaded and active
	#
	if ($fws->{plugins}->{'ECommerce'} eq '1') { 	print "ECommerce is installed!\n" }
	else { 						print "No ECommerce for you!\n" }


=cut

sub registerPlugin {
        my ($self, $plugin) = @_;

        eval 'use lib "'.$self->{'fileSecurePath'}.'/plugins";';
        
	#
        # get the plugin name if it is a server wide plugin
        #
        my $pluginName = $plugin;
        $pluginName =~ s/.*:://sg;

        #
        # add the plugin and register the init for it
        #
        eval 'use '.$plugin.';';

        if($@){ $self->FWSLog($plugin." could not be loaded\n".$@) }

        eval $plugin.'->pluginInit($self);';
        
	if($@){ $self->FWSLog($plugin." pluginInit failed\n".$@) }
	else { $self->{plugins}->{$plugin} = 1 }
}


=head1 WEB BASED RENDERING SEQUENCE

With the full web optimized version of FWS, the following sequence can be executed in this order to render web based content after new() is called:

	#
	# Get the form values from the environment
	#
	$fws->getFormValues();
	
	#
	# 404 page descisions
	#
	$fws->setSiteFriendly();
	
	#
	# run any site specific init scripts
	#
	$fws->runInit();
	
	#
	# get or set the session ID and restore retained information
	#
	$fws->setSession();
	
	#
	# set site values based on what we know now
	#
	$fws->setSiteValues();

	#
	# Do login procedures and set permissions
	#
	$fws->processLogin();
	
	#
	# Download files procedures if we are here to send a file
	#
	$fws->processDownloads();
	
	#
	# Run site actions that don't require security to use
	#
	$fws->runSiteActions();
	
	#
	# Run admin actions that require security to access
	#
	$fws->runAdminAction();
	
	#
	# Display the content we just created to the browser
	#
	$fws->displayContent();

NOTE: This version of the module is not capable of doing web based rendering.   For the web based version of this module visit www.frameworksites.com

=cut

=head1 AUTHOR

Nate Lewis, C<< <nlewis at gnetworks.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-fws-v2 at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=FWS-V2>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc FWS::V2


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=FWS-V2>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/FWS-V2>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/FWS-V2>

=item * Search CPAN

L<http://search.cpan.org/dist/FWS-V2/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2012 Nate Lewis.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of FWS::V2
