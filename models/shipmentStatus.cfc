/**
 * Name: Dachser Shipment Status API
 * Author: Gary Stanton (@SimianE)
 * Description: Wrapper for the Dachser Shipment Status API.
 */
component singleton accessors="true" extends="dachser" {

	/**
	 * Constructor
	 * @apikey  Your API key
	 */
	private shipmentStatus function init(
			string apikey
	){  
		setApikey(Arguments.apiKey);
		return this;
	}


	/**
	 * Retrieve shipment status
	 * @trackingNumbers The consignment number(s) to track. Separate multiple numbers with a comma.
	 *
	 * @return string|object Response data.
	 * @throws Exception
	 */
	public function retrieve(
			required string trackingNumber
		,	string customerID
	){
		Local.params = convertVariableNames(
				params = Arguments
			,	variableMap = {
					trackingNumber: 'tracking-number',
					customerID: 'customer-id'
				}
		);

		return makeRequest(
			endpointString 	= 'shipmentstatus'
		,	method 			= 'GET'
		,	params 			= Local.params
		)
	}
}