/* 
	Refresh databases, all data will be erased
*/

USE Restaurant
EXEC DeleteAllData
EXEC RefreshData
EXEC SetupRestaurantDataForTesting