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

	if (StructKeyExists(Variables, 'Dachser') && StructKeyExists(Form, 'trackingnumber') && Len(Form.trackingnumber)) {
		shipmentHistory = Dachser.getShipmentHistory().retrieve(Form.trackingnumber);
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
					<div class="col-sm-6">
						<div class="mr-6">
							<h2>Shipment History</h2>
							<p>Provide a tracking number or order number to retrieve details about a consignment.</p>
							<form method="POST">
								<div class="input-group">
									<input type="text" required="true" class="form-control" id="trackingnumber" name="trackingnumber" aria-describedby="trackingnumber" placeholder="Enter a tracking number" value="#StructKeyExists(Form, 'trackingNumber') ? encodeForHTML(Form.trackingNumber) : ''#">
									<div class="input-group-append">
										<button type="submit" class="btn btn-primary" type="button" name="action" value="tracking">Query Dachser shipment history API</button>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="col-sm-6">
						<h3>API key</h3>
						<p>#EncodeForHTML(dachser.getApikey())# <a href="?clearAPI" class="btn btn-danger btn-sm">Clear</a></p>
					</div>
				<cfelse> 
					<div class="col-sm-6">
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

			<cfif structKeyExists(Variables, 'shipmentHistory')>
				<hr />
				<cfdump var="#shipmentHistory#">
			</cfif>

			</cfoutput>
		</div>
	</body>
</html>