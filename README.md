# stocktest

A demo project showing some  features of [Alpha Vantage API](https://www.alphavantage.co);

## Limitations
1. API has a limitation with the free API key so you can make 5 requests per 1 minute and 500 requests per a day. For that reason, the app has predefined meta-data for 3 companies (See `CompanyMetaData`). Add more met-data to fetch more information about companies.
2. (Actual by date of this README is edited). The app will fail to fetch the information on Flutter Web because requests are blocked by the CORS policy.

## Installation
Since the service requires an API key to fetch information, follow these steps to set up this project:

1. Get an API key following [this link](https://www.alphavantage.co/support/#api-key).
2. Create `[project_root_folder]/lib/data.secrets.dart` with following content:
```
const alphavantageApiKey = 'YOUR_API_KEY';
```
3. Run the project and enjoy it!

## Documentation

The app has a good inline documentation. So checkout the files learn more about the project.