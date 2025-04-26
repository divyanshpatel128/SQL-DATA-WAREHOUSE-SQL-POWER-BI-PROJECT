/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/



CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
print '- =====================================================procedure start bronze.load_bronze ==================================================================================================================='

    BEGIN TRY 
		---------------  PROCEDURE TIME -----------
		DECLARE @startdate DATETIME,
				@enddate DATETIME;
		---------------  TABLE TIME ---------------

		DECLARE @TABLE_START_TIME DATETIME, @TABLE_END_TIME  DATETIME;


		print '============================================================================================================================='
		print('loading bronze layer')
		print '============================================================================================================================='

		print'______________________________________________________________________________________________________________________________'    
		print' crm folder table '
		print'_______________________________________________________________________________________________________________________________'
	
		--  bronze.crm_cust_info table 
		SET @TABLE_START_TIME=GETDATE()

		PRINT ('>>> TRUNCATE TABLE bronze.crm_cust_info <<<')
		TRUNCATE TABLE bronze.crm_cust_info;

		SET @startdate = GETDATE();

		PRINT ('>>> INSERT INTO bronze.crm_cust_info <<< ')
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Lenovo\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		); 
		SET @TABLE_END_TIME=GETDATE()
		 PRINT 'load duration : ' +'0.'+CAST(DATEDIFF(MILLISECOND, @TABLE_START_TIME, @TABLE_END_TIME) AS VARCHAR)+' MILLISECOND';
	
		PRINT '-----------------------------------------------------------------------------------------'

		SET @TABLE_START_TIME=GETDATE()
		
		PRINT('<<< truncate table  bronze.crm_prd_info >>>')
		truncate table  bronze.crm_prd_info 

		PRINT('<<< INERT INTO table  bronze.crm_prd_info >>>')
		bulk insert bronze.crm_prd_info
		from 'C:\Users\Lenovo\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
				firstrow=2,
				fieldterminator=',',
				tablock
		)
		SET @TABLE_END_TIME=GETDATE()

		 PRINT 'load duration : '+ '0.'+CAST(DATEDIFF(MILLISECOND, @TABLE_START_TIME, @TABLE_END_TIME) AS VARCHAR)+' MILLISECOND';
	
		PRINT '-----------------------------------------------------------------------------------------'
		
		SET @TABLE_START_TIME=GETDATE()
		
		PRINT('<<< truncate table bronze.crm_sales_details >>>')
		truncate table bronze.crm_sales_details

		PRINT('<<< INSERT table bronze.crm_sales_details >>>')
		bulk insert bronze.crm_sales_details 
		from 'C:\Users\Lenovo\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		)

		SET @TABLE_END_TIME=GETDATE()

		 PRINT 'load duration : '+ '0.'+CAST(DATEDIFF(MILLISECOND, @TABLE_START_TIME, @TABLE_END_TIME) AS VARCHAR)+' MILLISECOND';

		PRINT '-----------------------------------------------------------------------------------------'
		print'______________________________________________________________________________________________________________________________'    
		print(' create folder file  ERP – Enterprise Resource Planning')
		print'_______________________________________________________________________________________________________________________________'

		SET @TABLE_START_TIME=GETDATE()

		PRINT('<<< truncate table bronze.erp_loc_a101 >>>')
		truncate table  bronze.erp_loc_a101

		PRINT('<<< INSERT INTO erp_loc_a101 >>>')
		bulk insert  bronze.erp_loc_a101
		from 'C:\Users\Lenovo\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		)

		SET @TABLE_END_TIME=GETDATE()
		 PRINT  'load duration : '+'0.'+CAST(DATEDIFF(MILLISECOND, @TABLE_START_TIME, @TABLE_END_TIME) AS VARCHAR)+' MILLISECOND';

		PRINT '-----------------------------------------------------------------------------------------'
		
		SET @TABLE_START_TIME=GETDATE()
		PRINT('<<< TRUNCATE TABLE  bronze.erp_cust_az12 >>>')
		TRUNCATE TABLE  bronze.erp_cust_az12
	
		PRINT('<<< INSERT TABLE  bronze.erp_cust_az12 >>>')
		bulk insert bronze.erp_cust_az12
		from 'C:\Users\Lenovo\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with (
			firstrow =2,
			fieldterminator=',',
			tablock
		) 
		SET @TABLE_END_TIME=GETDATE()

		 PRINT  'load duration : '+'0.'+CAST(DATEDIFF(MILLISECOND, @TABLE_START_TIME, @TABLE_END_TIME) AS VARCHAR)+' MILLISECOND';

		PRINT '-----------------------------------------------------------------------------------------'

		SET @TABLE_START_TIME=GETDATE()
		PRINT('<<< truncate table bronze.erp_px_cat_g1v2 >>>')
		truncate table bronze.erp_px_cat_g1v2

		PRINT('<<< Insert into table bronze.erp_px_cat_g1v2 >>>')
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Lenovo\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			 firstrow=2,
			 fieldterminator =',',
			 tablock
	   )

		SET @TABLE_END_TIME=GETDATE()
		PRINT 'load duration : '+ '0.'+CAST(DATEDIFF(MILLISECOND, @TABLE_START_TIME, @TABLE_END_TIME) AS VARCHAR)+' MILLISECOND';
	
	END TRY 
	BEGIN CATCH
		PRINT('==========================================================================')
		PRINT('ERROR OCCURED DURING LOADING BRONZE LAYER');
		PRINT'ERROR MESSAGE'+ERROR_MESSAGE();
		PRINT 'ERROR NUMBER'+ CAST (ERROR_NUMBER() AS VARCHAR);
		PRINT 'ERROR STATE '+ CAST (ERROR_STATE() AS VARCHAR)
		PRINT 'ERROR LINE'+CAST (ERROR_LINE() AS VARCHAR);
		PRINT 'ERROR PROCEDURE'+ERROR_PROCEDURE();
		PRINT('==========================================================================')
	END CATCH
	
	PRINT'===================================================  end procedure  bronze.load_bronze ========================================================================================================================='
	
	SET @enddate = GETDATE();
    PRINT  'load duration : '+ '0.'+CAST(DATEDIFF(MILLISECOND, @startdate, @enddate)AS VARCHAR)+' MILLISECOND';
end 
