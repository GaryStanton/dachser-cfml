/**
 * Name: Dachser Core
 * Author: Gary Stanton (@SimianE)
 * Description: Core CFC to be extended by individual API cfcs
*/
component singleton accessors="true" {
	property name="apikey" 	type="string";
	property name="apiurl"  type="string" default="https://api.dachser.com/rest/v2/";

	property name="shipmentHistory";

	/**
	 * Constructor
	 * @apikey 	Your API key
	 */
	public dachser function init(
		required string apikey 
	){  
		setApikey(Arguments.apikey);
		setShipmentHistory(new shipmentHistory());
		getShipmentHistory().setApikey(Arguments.apikey);

		return this;
	}

	/**
	 * Makes a request to the API. Will return the content from the cfhttp request.
	 * @endpoint The request endpoint
	 * @body The body of the request
	 * @returnRaw When true return the response without parsing into structs and arrays
	 */
	private function makeRequest(
			required string endpointString
		,	string method = 'GET'
		,   boolean returnRaw = false
	){

		var requestURL  = getApiurl() & endpointString
		var result      = {};

		// Decide param types
		var paramType = 'url';
		switch (Arguments.method) {
			case 'GET':
				paramType = 'url';
				break;

			case 'POST': case 'PUT': case 'DELETE':
				paramType = 'formField';
				break;

			case 'XML':
				paramType = 'xml';
				Arguments.method = 'POST';
				break;

			case 'JSON': case 'JSONPOST':
				paramType = 'body';
				Arguments.method = 'POST';
				Arguments.headers['Content-Type'] = 'application/json';
				break;

			case 'JSONPUT':
				paramType = 'body';
				Arguments.method = 'PUT';
				Arguments.headers['Content-Type'] = 'application/json';
				break;
		}



		cfhttp(
			method  = Arguments.method,
			charset = "utf-8", 
			url     = requestURL,
			result  = "result"
		) {
			cfhttpparam(type="header", name="X-IBM-Client-Id", value="#getApikey()#");
			// Add parameters
			if (structKeyExists(Arguments, 'params') AND isStruct(Arguments.params)) {
				for (Local.thisParam in Arguments.params) {
					if (ListFindNoCase('xml,json', Local.thisParam) AND StructKeyExists(Arguments.params, Local.thisParam)) {
						cfhttpparam(type="#paramType#", value="#Arguments.params[Local.thisParam]#");
					}
					else if (StructKeyExists(Arguments.params, Local.thisParam)) {
						cfhttpparam(type="#paramType#", value="#Arguments.params[Local.thisParam]#", name="#lCase(Local.thisParam)#");
					}
				}
			}
		}

		if (StructKeyExists(result, 'fileContent') && isJSON(result.fileContent)) {
			return Arguments.returnRaw ? result.fileContent : deserializeJSON(result.fileContent);
		}
		else {
			return {errors: 'Unable to parse result'};
		}
	}


	/**
	 * Accepts a struct of variables and a map of variable names to return a struct containing new variable names and values
	 * @params - Struct of variables to convert
	 * @variableMap - Map of old variables to new
	 * @inclusive - When set to true, the returned struct will contain all variables that haven't been converted also. False and these variables are stripped.
	 *
	 * @return struct
	 */
	private function convertVariableNames(
			required struct params
		,	required struct variableMap
		,	boolean inclusive = false
	) {
		Local.ConvertedVariables = {};
		// Loop over struct and convert variable names
		for (Local.ThisParam in Arguments.Params) {
			// Check to see if this variable name is in the map
			if(structKeyExists(Arguments.VariableMap, Local.ThisParam)) {
				Local.ThisParamName = Arguments.VariableMap[Local.ThisParam];
			}
			else {
				if (Arguments.Inclusive) {
					Local.ThisParamName = Local.ThisParam;
				}
			}

			// Add converted variable to the new struct
			if (structKeyExists(Local, 'ThisParamName')) {
				Local.ConvertedVariables[Local.ThisParamName] = Arguments.Params[Local.ThisParam];						
			}
		}

		return Local.ConvertedVariables;
	}
}
