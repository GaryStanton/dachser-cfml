<!doctype html>

<cfscript>
	setting requesttimeout="600";
	if (StructKeyExists(URL, 'clearAPI')) {
		StructDelete(Session, 'apikey');
		location(url="/examples", addtoken="false");
	}

	if (StructKeyExists(Form, 'apikey') && Len(Form.apiKey)) {
		Session.apikey = reReplaceNoCase(Form.apikey, "[^a-zA-Z0-9]", "", "ALL");
	}

	if (StructKeyExists(Session, 'apikey')) {
		Dachser = new models.dachser(
			apikey = session.apikey
		);
	}

	if (StructKeyExists(Variables, 'Dachser') && StructKeyExists(Form, 'shippingHistory_trackingnumber') && Len(Form.shippingHistory_trackingnumber)) {
		results = Dachser.getShipmentHistory().retrieve(Form.shippingHistory_trackingnumber);
	}

	if (StructKeyExists(Variables, 'Dachser') && StructKeyExists(Form, 'shippingStatus_trackingnumber') && Len(Form.shippingStatus_trackingnumber)) {
		results = Dachser.getShipmentStatus().retrieve(Form.shippingStatus_trackingnumber);
	}

	if (StructKeyExists(Variables, 'Dachser') && StructKeyExists(Form, 'action_deliveryNotes')) {
		results = Dachser.getDeliveryNotes().retrieve(
			ArgumentCollection = Form
		);
	}
</cfscript>

<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
		<title>Dachser CFML examples</title>
	</head>

	<body>
		<div class="container">
			<h1>Dachser CFML examples</h1>
			<hr>

			<cfoutput>

			<div class="row">
				<cfif structKeyExists(Variables, 'Dachser')>
					<div class="col-sm-7">
						<div class="mr-7">
							<h2>Shipment Status</h2>
							<p>Provide a tracking number or order number to retrieve the status of one or more consignments.</p>
							<form method="POST">
								<div class="input-group">
									<input type="text" required="true" class="form-control" id="shippingStatus_trackingnumber" name="shippingStatus_trackingnumber" aria-describedby="shippingStatus_trackingnumber" placeholder="Enter a tracking number" value="#StructKeyExists(Form, 'shippingStatus_trackingNumber') ? encodeForHTML(Form.shippingStatus_trackingNumber) : ''#">
									<div class="input-group-append">
										<button type="submit" class="btn btn-primary" type="button" name="action_shipmentStatus" value="tracking">Query Dachser shipment status API</button>
									</div>
								</div>
							</form>
						</div>

						<hr />

						<div class="mr-7">
							<h2>Shipment History</h2>
							<p>Provide a tracking number or order number to retrieve details about one or more consignments.</p>
							<form method="POST">
								<div class="input-group">
									<input type="text" required="true" class="form-control" id="shippingHistory_trackingnumber" name="shippingHistory_trackingnumber" aria-describedby="shippingHistory_trackingnumber" placeholder="Enter a tracking number" value="#StructKeyExists(Form, 'shippingHistory_trackingNumber') ? encodeForHTML(Form.shippingHistory_trackingNumber) : ''#">
									<div class="input-group-append">
										<button type="submit" class="btn btn-primary" type="button" name="action_shipmentHistory" value="tracking">Query Dachser shipment history API</button>
									</div>
								</div>
							</form>
						</div>

						<hr />

						<div class="mr-7">
							<h2>Delivery Notes</h2>
							<p>Retrieve delivery notes</p>
							<form method="POST">
								<div class="input-group">
									<input type="text" class="form-control" id="referenceNumber1" name="referenceNumber1" aria-describedby="referenceNumber1" placeholder="Enter reference number 1" value="#StructKeyExists(Form, 'referenceNumber1') ? encodeForHTML(Form.referenceNumber1) : ''#">
									<input type="text" class="form-control" id="referenceNumber2" name="referenceNumber2" aria-describedby="referenceNumber2" placeholder="Enter reference number 2" value="#StructKeyExists(Form, 'referenceNumber2') ? encodeForHTML(Form.referenceNumber2) : ''#">
								</div>

								<div class="input-group">
									<input type="text" class="form-control" id="referenceNumber3" name="referenceNumber3" aria-describedby="referenceNumber3" placeholder="Enter reference number 3" value="#StructKeyExists(Form, 'referenceNumber3') ? encodeForHTML(Form.referenceNumber3) : ''#">
									<input type="text" class="form-control" id="referenceNumber4" name="referenceNumber4" aria-describedby="referenceNumber4" placeholder="Enter reference number 4" value="#StructKeyExists(Form, 'referenceNumber4') ? encodeForHTML(Form.referenceNumber4) : ''#">
								</div>

								<div class="input-group">
									<input type="date" class="form-control" id="deliveryOrderDate" name="deliveryOrderDate" aria-describedby="deliveryOrderDate" placeholder="Delivery order date" value="#StructKeyExists(Form, 'deliveryOrderDate') ? encodeForHTML(Form.deliveryOrderDate) : ''#">
									<input type="text" class="form-control" id="purchaseOrderNumber" name="purchaseOrderNumber" aria-describedby="purchaseOrderNumber" placeholder="Purchase order number" value="#StructKeyExists(Form, 'purchaseOrderNumber') ? encodeForHTML(Form.purchaseOrderNumber) : ''#">
								</div>

								<div class="input-group-append">
									<button type="submit" class="btn btn-primary" type="button" name="action_deliveryNotes" value="tracking">Query Dachser delivery notes API</button>
								</div>
							</form>
						</div>
					</div>
					<div class="col-sm-5">
						<h3>API key</h3>
						<p>#EncodeForHTML(dachser.getApikey())# <a href="?clearAPI" class="btn btn-danger btn-sm">Clear</a></p>
					</div>
				<cfelse> 
					<div class="col-sm-5">
						<div class="mr-6">
							<h2>API Key</h2>
							<p>Provide an active key to use the Dascher API</p>
							<form method="POST">
								<div class="input-group">
									<input type="text" required="true" class="form-control" id="apikey" name="apikey" aria-describedby="apikey" placeholder="Enter an API key">
									<div class="input-group-append">
										<button type="submit" class="btn btn-primary" type="button" name="action" value="tracking">Init API</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</cfif>
			</div>

			<cfif structKeyExists(Variables, 'results')>
				<hr />
				<cfdump var="#results#">
			</cfif>

			</cfoutput>
		</div>
	</body>
</html>