# Decidim::SocioDemographicAuthorizationHandler

Description.

## Usage

SocioDemographicAuthorizationHandler will be available as a Component for a Participatory
Space.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "decidim-socio_demographic_authorization_handler", git: "https://github.com/OpenSourcePolitics/decidim-module-socio_demographic_authorization_handler.git", branch: "develop"
```

And then execute:

```bash
bundle
```

Now the module should be added to your current Decidim project.

### Override the authorization form

You can override the current form for adding or creating specific fields according to your needs. To do so, we will have to override the form partial and the socio_demographic service

First in your decidim project, create a new file `app/views/socio_demographic_authorization/_form.html.erb`. This file contains the form partial visible when user fill the authorization form.

Then, manage the newly created form with the service : `app/services/socio_demographic_authorization_handler.rb`. This file contains the form validations and attributes.


## Contributing

See [Decidim](https://github.com/decidim/decidim).

## License

This engine is distributed under the GNU AFFERO GENERAL PUBLIC LICENSE.
