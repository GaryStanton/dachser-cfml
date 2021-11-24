# Dachser CFML

Dachser CFML provides a wrapper for the Dachser API.
At present, the module only includes access to the shipment status, shipment history & deliveryNotes APIs.
Further updates may include access to other APIs in the Dachser library.
Pull requests welcome.

## Installation
```js
box install dachsercfml
```

## Examples
An example application is at `/examples`. Simply spin this up in CommandBox for a quick demonstration.


## Usage
The Dachser CFML wrapper consists of a core CFC and separate CFCs, representing Dachser's API modules.
The wrapper may be used standalone, or as a ColdBox module.
Obtain API keys and associate modules to your Dachser application here: https://api-portal.dachser.com/


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
	apikey = getSystemSetting("DACHSER_API_KEY", "")
}
```

### Retrieve shipment status / history
Retrieving shipment data is a simple call to the retrieve function with your tracking number.
A tracking number may be one of the following:
Customer order number, DACHSER consignment number, House Bill of Lading, House AirWay Bill, Container number or SSCC.

```cfc
shipmentStatusResponse = dachser.getShipmentStatus().retrieve('2529335774806016');
shipmentHistoryResponse = dachser.getShipmentHistory().retrieve('2529335774806016');
```

Optionally, you may filter by customer number using the customerID field:

```cfc
shipmentHistoryResponse = dachser.getShipmentHistory().retrieve(
	trackingNumber = '2529335774806016',
	customerID = '2179866474577920'
);
```

## Retreive delivery notes
Retrieve delivery notes using reference numbers, PO numbers and delivery dates

```cfc
deliveryNoteResponse = dachser.getDeliveryNotes().retrieve(
	referenceNumber1 = '2529335774806016',
	deliveryOrderDate = '2021-11-24',
	purchaseOrderNumber = '123456789'
);
```


### Modules
The Dachser API is split into individual modules that must be added to your Dachser application.
Currently this wrapper only works with shipment status, shipment history & deliveryNotes modules, however it is structured such that other modules may be added in the future.
For flexibility, each module is a separate CFC that extends the core and is also instantiated by the core itself.
Therefore you may instantiate the shipmentHistory CFC standalone, or instantiate the Dachser core CFC and make calls to dacsher.getShipmentHistory(), as in the example above.



## Author
Written by Gary Stanton.  
https://garystanton.co.uk
