/**
 * Name: Dachser Delivery Notes API
 * Author: Gary Stanton (@SimianE)
 * Description: Wrapper for the Dachser Shipment Status API.
 */
component singleton accessors="true" extends="dachser" {

	/**
	 * Constructor
	 * @apikey  Your API key
	 */
	private deliveryNotes function init(
			string apikey
	){  
		setApikey(Arguments.apiKey);
		return this;
	}


	/**
	 * Retrieve delivery notes
	 * @referenceNumber1 Incoming reference number 1
	 * @referenceNumber2 Incoming reference number 2
	 * @referenceNumber3 Incoming reference number 3
	 * @deliveryOrderDate Delivery order date (format YYYY-MM-DD)
	 * @purchaseOrderNumber Purchase Order Number
	 *
	 * @return string|object Response data.
	 * @throws Exception
	 */
	public function retrieve(
			string referenceNumber1
		,	string referenceNumber2
		,	string referenceNumber3
		,	string deliveryOrderDate
		,	string purchaseOrderNumber
		,	string customerID
	){
		Local.params = convertVariableNames(
				params = Arguments
			,	variableMap = {
					referenceNumber1: 'reference-number1'
				,	referenceNumber2: 'reference-number2'
				,	referenceNumber3: 'reference-number3'
				,	deliveryOrderDate: 'delivery-order-date'
				,	purchaseOrderNumber: 'purchase-order-number'
				,	customerID: 'customer-id'
			}
		);

		return makeRequest(
			endpointString 	= 'deliverynotes'
		,	method 			= 'GET'
		,	params 			= Local.params
		)
	}
}