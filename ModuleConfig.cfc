/**
* This module wraps the Dachser API
**/
component {

	// Module Properties
	this.modelNamespace			= 'dachsercfml';
	this.cfmapping				= 'dachsercfml';
	this.parseParentSettings 	= true;

	/**
	 * Configure
	 */
	function configure(){

		// Skip information vars if the box.json file has been removed
		if( fileExists( modulePath & '/box.json' ) ){
			// Read in our box.json file for so we don't duplicate the information above
			var moduleInfo = deserializeJSON( fileRead( modulePath & '/box.json' ) );

			this.title 				= moduleInfo.name;
			this.author 			= moduleInfo.author;
			this.webURL 			= moduleInfo.repository.URL;
			this.description 		= moduleInfo.shortDescription;
			this.version			= moduleInfo.version;
		}

		// Settings
		settings = {
				'apikey' : ''
		};
	}

	function onLoad(){
		binder.map( "dachser@dachsercfml" )
			.to( "#moduleMapping#.models.dachser" )
			.asSingleton()
			.initWith(
					apikey 	= settings.apikey
			);

		binder.map( "shipmentHistory@dachsercfml" )
			.to( "#moduleMapping#.models.shipmentHistory" )
			.asSingleton()
			.initWith(
					apikey 	= settings.apikey
			);
	}

}