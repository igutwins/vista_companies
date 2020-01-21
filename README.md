## Project Title: Private Equity Portfolio Company Scraper Tool for Vista Private Equity's Portfolio

## Usage Instructions

To run this program, type "ruby ./bin/vista_companies" into your terminal.

The program will present you with four options - you can either view all (1) current, (2) former, or (3) current and former Vista companies, or (4) view a listing of all industry categories Vista has invested in historically.

The program allows the user to make secondary and tertiary selections - in the case of choices (1) - (3), the user may further select one of the resulting companies and be presented with detailed information about that company. In the case of (4), the user can select an industry for further inspection, at which point the program will provide a listing of all of Vista's current and former investments in the selected industry.

The user can always navigate to previous menus by typing "list" or "exit" to leave the program.  

## How it Works

The program uses Ruby gem Nokogiri to scrape Vista's website (https://www.vistaequitypartners.com/companies/), and creates two primary Classes of objects - Companies (or "PortCos" - short for Portfolio Companies) and Industries - which are manipulated and presented via the CLI. An Industry has many Companies while a Company may only have one Industry.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the VistaCompanies project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/'beautiful-stack-9050'/vista_companies/blob/master/CODE_OF_CONDUCT.md).
