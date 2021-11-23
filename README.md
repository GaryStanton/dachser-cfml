# Dachser CFML

Dachser CFML provides a wrapper for the Dachser API.
At present, the module only includes access to the shipment history API.
Further updates may include access to other APIs in the Dachser library.
Pull requests welcome.

## Installation
```js
box install dachsercfml
```

## Examples
An example application is at `/examples`. Simply spin this up in CommandBox for a quick demonstration.


## Usage
The Dachser CFML wrapper currently consists of a single models, representing Dachser's 'Shipment History' API.
The wrapper may be used standalone, or as a ColdBox module.


### Standalone
```cfc
	dachser = new models.dachser(
		apikey = "YOUR_API_KEY"
	);
```

### ColdBox
```cfc
dachser	= getInstance("dachser@dachsercfml");
```
alternatively inject it directly into your handler
```cfc
property name="dachser" inject="dachser@dachsercfml";
```

When using with ColdBox, you'll want to insert your API authentication details into your module settings:

```cfc
dachsercfml = {
		apikey 		= getSystemSetting("DACHSER_API_KEY", "")
}
```

### Retrieve shipment history
Retrieving shipment history is a simple call to the retrieve function with your tracking number.
A tracking number may be one of the following:
Customer order number, DACHSER consignment number, House Bill of Lading, House AirWay Bill, Container number or SSCC.

```cfc
shipmentHistoryResponse = dachser.getShipmentHistory().retrieve('2529335774806016');
```

Optionally, you may filter by customer number using the customerID field:

```cfc
shipmentHistoryResponse = dachser.getShipmentHistory().retrieve(
	trackingNumber = '2529335774806016',
	customerID = '2179866474577920'
);
```


### Modules
The Dachser API is split into individual modules that must be added to your Dachser application.
Currently this wrapper only works with the Shipment History module, however it is structured such that other modules may be added in the future.
For flexibility, each module is a separate CFC that extends the core and is also instantiated by the core itself.
Therefore you may instantiate the shipmentHistory CFC standalone, or instantiate the Dachser core CFC and make calls to dacsher.getShipmentHistory(), as in the example above.



## Author
Written by Gary Stanton.  
https://garystanton.co.uk
