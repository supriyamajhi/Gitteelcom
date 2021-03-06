
'************************************************************************************************************************************************
'Function Name: Login_ValidateMsg()
'Function Desc : Validtaes the error or Success message after login 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : Login_ValidateMsg()
'Author: Supriya
'Created Date : 21/08/14
'Last Edited Date : 
'Modification History: 
' 
'************************************************************************************************************************************************



Function LogPad(vStatus,vDesc)
	    Set oLog_FSO=CreateObject("Scripting.FileSystemObject")
	 
		
        
'        'CHECKING FOR THE EXISTENCE OF THE LOG FILE
'        If Not oLog_FSO.FileExists(Trim(vLogPath)) Then
'                    Set oNotepadFile = oLog_FSO.CreateTextFile(Trim(Environment("ResultLog")))
'                    oNotepadFile.WriteLine("Date: "&Date)
'                    oNotepadFile.WriteLine("Time: "&Time)
'        Else
                    Set oNotepadFile = oLog_FSO.OpenTextFile(Environment("ResultLog"),8,True)

'                    Do while (err.number = 424)
'                            err.clear
'                            wait 0.5
'                            Set oNotepadFile = oLog_FSO.OpenTextFile(Environment("ResultLog"),8,True)
'                             
'
'                    Loop
'        End If
''                        
        
        Select Case(vStatus)
                Case 1:vStatus="PASSED"
                Case 2:vStatus="FAILED"
                Case Else:vStatus="DONE"
        End Select
      
        oNotepadFile.WriteLine("["&Now&"] " & Trim(vDetails) & ", Status-" & Trim(vStatus) & ", Result-" & Trim(vDesc))
        
        Set oNotepadFile=Nothing
        Set oLog_FSO=Nothing
End Function


Function GoogleLogin()
	On Error resume Next 	
 
   Set oLog_FSO=CreateObject("Scripting.FileSystemObject")
	    Set oNotepadFile= oLog_FSO.OpenTextFile ( "D:\Users\sumajhi\Desktop\AutomationExample\Automation\Result\Log\Log_131215130180582310.txt",8)
		oNotepadFile.WriteLine "Starting Test automation from UFT "
		Set oNotepadFile = Nothing
 	Set  oLog_FSO = Nothing 
 	
 	
 	For i  = 1 To 5 Step 1
 		
 
 		SystemUtil.Run "www.google.com"
		Browser("GoogleBrw").Page("Google").WebEdit("q").Set "Search for UFT  :-" & i
	 
 
			Browser("GoogleBrw").Page("Google").WebButton("Google Search").Click
 CafeReporter "Login_ValidateExpMsg","Login_ValidateExpMsg","Pass","Error Messge is displayed as expected.","Nope.Expeceted error Message:- " & 	vExpErrMsg & "Actual error Message :-"	& vActMsg		

       Call LogPad (1, i & "Searched the Google Page")
       ' SystemUtil.CloseProcessByName( "iexplore.exe")

 	Next
End Function


Function FindADoctor()
	On Error resume Next 	
 
 
 	 
 		SystemUtil.Run "iexplore.exe","https://dignityhealth.org/"
 		
 		wait(20)
		  Call LogPad (3,   "**********TESTCASE - FIND  A DOCTOR ********")
Browser("Dignity Health | Hello").Page("Dignity Health | Hello").Link("Find a Doctor").Engine("#CLICK--1")
		Browser("Dignity Health | Our Doctors").Page("Dignity Health | Our Doctors").WebEdit("WebEdit").Engine("#SET--Arizona")
		Browser("Dignity Health | Our Doctors").Page("Dignity Health | Our Doctors").WebButton("WebButton").Engine("#CLICK--2")

  	If  (Browser("Dignity Health | Our Doctors").Page("Dignity Health | Our Doctors").Link("Arizona").Exists(1)) Then 
  
  

 		CafeReporter "Doctors_FoundSuccess message ","Doctors_FoundSuccess message","Pass","Doctors are found in th given area.","Done"	

       Call LogPad (1,   "Doctors are found in th given area.e")
       
       Else
       CafeReporter "Doctors_FoundSuccess message ","Doctors_FoundSuccess message","Fail","Doctors are not  found in th given area.","Done"	

       Call LogPad (2,   "Doctors are not found in th given area.")
       
       
       End If 
        SystemUtil.CloseProcessByName( "iexplore.exe")

  
End Function

Function CareerFinder()


	
	SystemUtil.Run "iexplore.exe","https://dignityhealth.org/"
	
	  Call LogPad (3,   "**********TESTCASE - CAREERFINDER********")
 

	
	Browser("Dignity Health | Our Doctors").Page("Dignity Health | Contact").Link("CAREERS").Engine("#CLICK--2")
Browser("Search and apply for healthcar").Page("Search and apply for healthcar").Link("Click Here To Enter").Engine("#CLICK--5")
Browser("Search and apply for healthcar").Page("Dignity Health Careers").WebEdit("keyword").Engine("#SET--Doctor")
Browser("Search and apply for healthcar").Page("Dignity Health Careers").WebButton("SUBMIT >").Engine("#CLICK--5")
 
 
	
	
If  Browser("Dignity Health Careers").Page("Dignity Health Careers").WebElement("Faculty Neuropsychologist").Exists(1) Then 
 


 		CafeReporter "CareerFinder  ","CareerFinder ","Pass","Jobs are found in th given criteria.","Done"	

       Call LogPad (1,   "Careers  are found in the given Search criteria ")
       
     Else
       CafeReporter "CareerFinder  ","CareerFinder ","Fail","Job opportunities found    are not  found in th given serach crieria .","Done"	

       Call LogPad (2,   "Careers  are not  found in the given Search criteria")
       
       
   End If 
   SystemUtil.CloseProcessByName( "iexplore.exe")

End Function






Function Login_ValidateMsg(Byval vMsg)


 On Error Resume Next 
 
 	Select Case Ucase(vMsg)
 		
 		
 		Case "ERRMSG"
 		
 				vExpErrMsg = GetXML("LOGIN","ERROR")
 				
 				Browser("Datahub").Page("Datahub").WebElement("ErrorMsgLogin").SetTOProperty "innertext", vExpErrMsg
 				
 				
 				vActMsg = Browser("Datahub").Page("Datahub").WebElement("ErrorMsgLogin").GetROProperty("innertext")
 				
 				If Browser("Datahub").Page("Datahub").WebElement("ErrorMsgLogin").Exist(20) Then
 				
 					CafeReporter "Login_ValidateExpMsg","Login_ValidateExpMsg","Pass","Error Messge is displayed as expected." &vActMsg,"Yes"
 				Else
					CafeReporter "Login_ValidateExpMsg","Login_ValidateExpMsg","Fail","Error Messge is displayed as expected.","Nope.Expeceted error Message:- " & 	vExpErrMsg & "Actual error Message :-"	& vActMsg		
 					
 				End If   
				
				
					
		Case "SUCCESS"
 		      
			'Convert the Language to English	
				With Browser("Datahub").Page("Welcome To DataHub")
					If  Browser("Datahub").Page("Welcome To DataHub").Link("UserName_Link").Exist(10) Then
						
										
						
						.Sync
					   	.Engine("#EXIST--Y")		 
						.Link("UserName_Link").Engine("#CLICK--2")
						.Link("Select Display LanguageCurrent").Engine("#CLICK--2")				
						.Link("EnglishEnglish").Engine("#CLICK--2")
						CafeReporter "Login","Login Successful","Pass","Logged in  successfully","Login Success"
						
					 End If	  	
				End With
					
	
 		
 	End Select
	
	
	
		If Err.Number <> 0 Then					
			CafeReporter "Login_ValidateMsg","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
		End If	
	
End Function

'************************************************************************************************************************************************
'Function Name: Login_Wait(vWaittime)
'Function Desc : waits for specified time after Logging  into the Datahub application .
'Arguments: Uses Cafe framework
'Return : Nil
'Example : Login_Wait()
'Author: Matt
'Created Date : 19/09/14
'Last Edited Date : 
'Modification History: 
' 
'************************************************************************************************************************************************


Function Login_Wait(vWaittime)
	
	On Error Resume Next 
	 
		min = vWaittime/60
	
		If Err.Number <> 0 Then					
			CafeReporter "Login_Wait","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""	
		Else	
			CafeReporter "Login_Wait","Login_Wait","Pass","Waited for'"& min & "'minutes ","Yes"		
		End If	
	
End Function
	



Function TelerikSelect(ByRef obj,ByVal Value)
	
	obj.Object.value = Trim(Value)
	
End Function



'************************************************************************************************************************************************
'Function Name: WebTable_Exist(ByRef obj)
'Function Desc : Checks if the Webtable Exists  .
'Arguments: Uses Cafe framework
'Return : Nil
'Example : WebTable_Exist(ByRef obj)
'Author: Matt
'Created Date : 19/09/14
'Last Edited Date : 
'Modification History: 
' 
'************************************************************************************************************************************************

Function WebTable_Exist(ByRef obj)

	If obj.Exist(20) Then
		
			CafeReporter "Datahub","WebTable_Exist","Pass","'" & Trim(obj.GetTOProperty("TestObjName")) &"' table is found.","Exist"								
			Else			
			CafeReporter "Datahub","WebTable_Exist","Pass","'" & Trim(obj.GetTOProperty("TestObjName")) &"' table is found.","Not visible"					
		
	End If
	
End Function

	
'************************************************************************************************************************************************
'Function Name: CSplMP_ConfCreation()
'Function Desc : Function handles the pop window, displayed after creating MP. Moreover confirms the MP is successfully created.
'Arguments: Nil
'Return : Nil
'Example : CreateSpcMP_ConfCreation()
'Author: Matt
'Created Date : 04/06/14
'Last Edited Date : 
'Modification History:
'20/06 - 	Function name modified from MP_ConfirmCreation to CSplMP_ConfCreation()()
'************************************************************************************************************************************************
	
	
	
Function CSplMP_ConfCreation()
	
	
	On Error Resume Next
	
			   'PopUp Message Window
				If Browser("Datahub").Page("Create special metering").Frame("CreateSpecialMP").Exist(100) Then
					CafeReporter "CSplMP_ConfCreation","Create Special Metering Point","Pass","Pop up screen 'Create Metering Point(master Data) displayed","Displayed"					
					Else	
					CafeReporter "CSplMP_ConfCreation","Create Special Metering Point","Fail","Pop up screen 'Create Metering Point(master Data) displayed","Displayed"					
				End If

				
				'Verify EffectuationDate
				
				'Get Dt from CrtMetPoint Window
				vEffectuationDt = Browser("Datahub").Page("Create special metering").Frame("CreateSpecialMP").WebEdit("EffectuationDate").GetROProperty("value")
				
				If vEffectuationDt = getDate_DDMMYYYY() Then
				
					CafeReporter "CSplMP_ConfCreation","Create Special Metering Point","Pass","Pop up screen - Effectualtion Date as today","Effectuation date was set as today"					
					Else	
					CafeReporter "CSplMP_ConfCreation","Create Special Metering Point","Fail","Pop up screen - Effectualtion Date as today","Effectuation date:" & vEffectuationDt					
					
				End If
				
				Browser("Datahub").Page("Create special metering").Frame("CreateSpecialMP").WebElement("SubmitDHButton").Click
				
				Browser("Datahub").Page("Create special metering").WebElement("SuccessMsgLabel").WaitProperty "visible",True,50	'Sync for message to be visible.
				
				'Validate whether the submit was successful - If error - capture - report - exit function.
				If Browser("Datahub").Page("Create special metering").WebElement("SuccessMsgLabel").GetROProperty("visible") <> True Then
					CafeReporter "CSplMP_ConfCreation","Create Special Metering Point","Fail","Metering Point has been created successfuly","Failed"
					Exit Function
				End If	
				
				
			    'Success Message Verification
				vMsg = Browser("Datahub").Page("Create special metering").WebElement("SuccessMsgLabel").GetROProperty("innertext")				
				vSuccessMsg = GetXML("CREATE_SPLMP","SUCCESS_MSG")
				
				
				If StrComp(vMsg,vSuccessMsg,1) = 0 Then
					CafeReporter "CSplMP_ConfCreation","Create Special Metering Point","Pass","Metering Point has been created successfuly","Created"					
					Else	
					CafeReporter "CSplMP_ConfCreation","Create Special Metering Point","Fail","Metering Point has been created successfuly","Failed"					
				End If
	
	
		If Err.Number <> 0 Then
			CafeReporter "CSplMP_ConfCreation","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
		End If
	
	
	
End Function

'************************************************************************************************************************************************
'Function Name: CSplMP_SetEffectuation(Byval Dt, ByVal Msg)
'Function Desc : Function handles the pop window, displayed after creating MP. Set the user defined Effectuation date and confirms the MP is successfully created.
'Arguments: String Dt
'String Msg - Success / Err
'Return : Nil
'Example : CSplMP_SetEffectuation("0","Err")
'Author: Matt
'Created Date : 07/07/14
'Last Edited Date : 
'Modification History:
'************************************************************************************************************************************************
	
	
	
Function CSplMP_SetEffectuation(Byval Dt, Byval vMsg)
	
	
	On Error Resume Next
	
			   '1.0 PopUp Message Window
				If Browser("Datahub").Page("Create special metering").Frame("CreateSpecialMP").Exist(100) Then
					CafeReporter "CSplMP_SetEffectuation","Create Special Metering Point","Pass","Pop up screen 'Create Metering Point(master Data) displayed","Displayed"					
					Else	
					CafeReporter "CSplMP_SetEffectuation","Create Special Metering Point","Fail","Pop up screen 'Create Metering Point(master Data) displayed","Displayed"					
				End If

				'< TO DO : CONFIRM WHETHER THE DEFAULT EFFECTUATION DATE (ED) IS TODAY>
				'< Done : The ED is by default today as per FD.		- Inputs from Jarmila>
				
				'2.0 Validate the default Effectuation date.
				
				'Get Dt from CrtMetPoint Window
				vEffectuationDt = Browser("Datahub").Page("Create special metering").Frame("CreateSpecialMP").WebEdit("EffectuationDate").GetROProperty("value")
				If vEffectuationDt = getDate_DDMMYYYY() Then
				
					CafeReporter "CSplMP_SetEffectuation","Create Special Metering Point","Pass","Pop up screen - Effectualtion Date as today","Effectuation date was set as today"					
					Else	
					CafeReporter "CSplMP_SetEffectuation","Create Special Metering Point","Fail","Pop up screen - Effectualtion Date as today","Effectuation date:" & vEffectuationDt					
					
				End If
				
				
				'3.0 Get New EffectuationDate
				 Environment.Value("Effectuation_Dt") = WorkingDay(Trim(Dt))	
				 
				 'Set Effectuation Date & Submit
				 Browser("Datahub").Page("Create special metering").Frame("CreateSpecialMP").WebEdit("EffectuationDate").Set Trim(Replace(Environment.Value("Effectuation_Dt"),"-","/"))	
				 Browser("Datahub").Page("Create special metering").Frame("CreateSpecialMP").WebElement("SubmitDHButton").Click
				 

				'4.0	Handle Success/ Failure
			    Select Case Ucase(Trim(vMsg))
					
					Case "SUCCESS"
					
							    'Success Message Verification
							    If Browser("Datahub").Page("Create special metering").WebElement("SuccessMsgLabel").WaitProperty("visible",True,15000) Then
							    	vMsg = Browser("Datahub").Page("Create special metering").WebElement("SuccessMsgLabel").GetROProperty("innertext")				
									vSuccessMsg = GetXML("CREATE_SPLMP","SUCCESS_MSG")
									Else
									vSuccessMsg = "Error. Object not visible."
									CafeReporter "CSplMP_SetEffectuation","Create Special Metering Point","Fail","Metering Point has been created successfuly","Failed"					
							    End If
								
								
								
								If StrComp(vMsg,vSuccessMsg,1) = 0 Then
									CafeReporter "CSplMP_SetEffectuation","Create Special Metering Point","Pass","Metering Point has been created successfuly","Created"					
									Else	
									CafeReporter "CSplMP_SetEffectuation","Create Special Metering Point","Fail","Metering Point has been created successfuly","Failed"					
								End If
			

					Case "ERR"
					
							Dt_Mentioned_Err = DateAdd("d",-1,Environment.Value("Effectuation_Dt"))

							'**********************			Change format from dd-mm-yyyy to yyyy-mm-dd		***********************
							
							yyyy = Year(Dt_Mentioned_Err) 
							mm   = Month(Dt_Mentioned_Err) 
							dd	 = Day(Dt_Mentioned_Err)
							
							
							If Len(mm) < 2Then	
								mm = "0" & mm
							End If
							
							If Len(dd) < 2Then	
								dd = "0" & dd
							End If
							
							StrEffDt = trim(yyyy) & "-" & Trim(mm) &"-"& Trim(dd)
							
							'**********************************************************************************************************
							
							
							vErrMsg = Browser("Datahub").Page("Create special metering").Frame("CreateSpecialMP").WebElement("Rejection_ErrMsg").GetROProperty("innertext")	'Actual Error message
							
							
							Exp_Err_Msg = GetXML("CREATE_SPLMP","ERR_MSG") 	'Expected Error Msg
							
							
							Exp_Err_Msg = Replace(Exp_Err_Msg,"[D]",StrEffDt)	'Replacing the tag D, with effectuation date.
							
							
							
							If Strcomp(Trim(vErrMsg),Trim(Exp_Err_Msg),1) = 0 Then
									CafeReporter "CSplMP_ConfCreation","Create Special Metering Point","Pass","Expected Error Message '" & Exp_Err_Msg &"' was displayed.","Yes"					
								Else
									CafeReporter "CSplMP_ConfCreation","Create Special Metering Point","Pass","Expected Error Message was displayed.","No. Expected Message = '" & Exp_Err_Msg & "', Actual Msg =' " & vErrMsg &"'"					
							End If
	
					Case Else
							CafeReporter "CSplMP_SetEffectuation","Incorrect Paramenter","FAIL","ERR Number: 2001, ERR Description: Incorrect parameter for the function'CSplMP_SetEffectuation'","Expected paramenter for 'MSG' is either Success/Err"					
					
				 End Select
				
				
	
	
		If Err.Number <> 0 Then
			CafeReporter "CSplMP_SetEffectuation","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
		End If
	
	
	
End Function


'************************************************************************************************************************************************
'Function Name: CMP_SetEffectuation(Byval Dt, ByVal Msg)
'Function Desc : Function handles the pop window, displayed after creating MP. Set the user defined Effectuation date and confirms the MP is successfully created.
'Arguments: String Dt
'			String Msg - Success / Err
'Return : Nil
'Example : CMP_SetEffectuation("0","Err")
'Author: Matt
'Created Date : 17/07/14
'Last Edited Date : 
'Modification History:
'************************************************************************************************************************************************
	
	
	
Function CMP_SetEffectuation(Byval Dt, Byval vMsg)
	
	
	On Error Resume Next
	
			   '1.0 PopUp Message Window
				If Browser("Datahub").Page("Create metering point").Frame("CreateMP").Exist(100) Then
					CafeReporter "CMP_SetEffectuation","Create Metering Point","Pass","Pop up screen 'Create Metering Point(master Data) displayed","Displayed"					
					Else	
					CafeReporter "CMP_SetEffectuation","Create Metering Point","Fail","Pop up screen 'Create Metering Point(master Data) displayed","Not Displayed"					
				End If

				'< TO DO : CONFIRM WHETHER THE DEFAULT EFFECTUATION DATE (ED) IS TODAY>
				'< Done : The ED is by default today as per FD.		- Inputs from Jarmila>
				
				'2.0 Validate the default Effectuation date.
				
				'Get Dt from CrtMetPoint Window
				vEffectuationDt = Browser("Datahub").Page("Create metering point").Frame("CreateMP").WebEdit("EffectuationDate").GetROProperty("value")
				If vEffectuationDt = getDate_DDMMYYYY() Then
				
					CafeReporter "CMP_SetEffectuation","Create Metering Point","Pass","Pop up screen - Effectualtion Date as today","Effectuation date was set as today"					
					Else	
					CafeReporter "CMP_SetEffectuation","Create Metering Point","Fail","Pop up screen - Effectualtion Date as today","Effectuation date:" & vEffectuationDt					
					
				End If
				
				
				'3.0 Get New EffectuationDate
				 Environment.Value("Effectuation_Dt") = WorkingDay(Trim(Dt))	
				 
				 'Set Effectuation Date & Submit
				 Browser("Datahub").Page("Create metering point").Frame("CreateMP").WebEdit("EffectuationDate").Set Trim(Replace(Environment.Value("Effectuation_Dt"),"-","/"))	
				 Browser("Datahub").Page("Create metering point").Frame("CreateMP").WebElement("SubmitDHButton").Click
				 

				'4.0	Handle Success/ Failure
			    Select Case Ucase(Trim(vMsg))
					
					Case "SUCCESS"
					
							    'Success Message Verification
							   If Browser("Datahub").Page("Create metering point").WebElement("SuccessMsgLabel").WaitProperty("visible",True,15000) Then 
							    	vMsg = Browser("Datahub").Page("Create metering point").WebElement("SuccessMsgLabel").GetROProperty("innertext")				
									vSuccessMsg = GetXML("CREATE_SPLMP","SUCCESS_MSG")
									Else
									VSuccessMsg = "Error. Object not visible"	
									CafeReporter "CMP_SetEffectuation","Create Metering Point","Fail","Metering Point has been created successfuly","Failed"														
								End If								
								
								
								If StrComp(vMsg,vSuccessMsg,1) = 0 Then
									CafeReporter "CMP_SetEffectuation","Create Metering Point","Pass","Metering Point has been created successfuly","Created"					
									Else	
									CafeReporter "CMP_SetEffectuation","Create Metering Point","Fail","Metering Point has been created successfuly","Failed"					
								End If
			

					Case "ERR"
					
							Dt_Mentioned_Err = DateAdd("d",-1,Environment.Value("Effectuation_Dt"))

							'**********************			Change format from dd-mm-yyyy to yyyy-mm-dd		***********************
							
							yyyy = Year(Dt_Mentioned_Err) 
							mm   = Month(Dt_Mentioned_Err) 
							dd	 = Day(Dt_Mentioned_Err)
							
							
							If Len(mm) < 2Then	
								mm = "0" & mm
							End If
							
							If Len(dd) < 2Then	
								dd = "0" & dd
							End If
							
							StrEffDt = trim(yyyy) & "-" & Trim(mm) &"-"& Trim(dd)
							
							'**********************************************************************************************************
							
							
							vErrMsg = Browser("Datahub").Page("Create metering point").Frame("CreateMP").WebElement("Rejection_ErrMsg").GetROProperty("innertext")	'Actual Error message
							
							
							Exp_Err_Msg = GetXML("CREATE_SPLMP","ERR_MSG") 	'Expected Error Msg
							
							
							Exp_Err_Msg = Replace(Exp_Err_Msg,"[D]",StrEffDt)	'Replacing the tag D, with effectuation date.
							
							
							
							If Strcomp(Trim(vErrMsg),Trim(Exp_Err_Msg),1) = 0 Then
									CafeReporter "CMP_SetEffectuation","Create Metering Point","Pass","Expected Error Message '" & Exp_Err_Msg &"' was displayed.","Yes"					
								Else
									CafeReporter "CMP_SetEffectuation","Create Metering Point","Pass","Expected Error Message was displayed.","No. Expected Message = '" & Exp_Err_Msg & "', Actual Msg =' " & vErrMsg &"'"					
							End If
	
					Case Else
							CafeReporter "CMP_SetEffectuation","Incorrect Paramenter","FAIL","ERR Number: 2001, ERR Description: Incorrect parameter for the function'CSplMP_SetEffectuation'","Expected paramenter for 'MSG' is either Success/Err"					
					
				 End Select
				
				
	
	
		If Err.Number <> 0 Then
			CafeReporter "CSplMP_SetEffectuation","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
		End If
	
	
	
End Function


'************************************************************************************************************************************************
'Function Name: ViewMeteringPoint()
'Function Desc : Verifies the Metering Point detail, with reference to the update given in CreateMP screen. 
'Arguments: Nil
'Return : Nil
'Example : ViewMeteringPoint
'Author: Matt
'Created Date : 24/06/14
'Last Edited Date : 
'Modification History:
'************************************************************************************************************************************************
Function ViewMeteringPoint()
	
				On Error Resume Next
				
						'1.0	DATA		
						Table     = GetXML("VIEW_MP","TABLE") 'Environment.Value("ScriptID")
						vScriptID = GetXML("VIEW_MP","SCRIPT_ID")  'Environment.Value("ScriptID")
						vStep     = GetXML("VIEW_MP","STEP") 'Environment.Value("ScriptID")
						
						
				
						'1.1 QUERY
						 StrSQL = "Select * from " & Trim(Table) & " where Script_ID = '"& Trim(vScriptID) & "' and Step = '" & Trim(vStep) &"'"
						
						
						'2.0 DATADICTIONARY		
						 GetRecord(StrSQL)
						 
						 vMeteringPointID	 			= Environment.Value("MeteringPoint") 'GetXML("DATAHUB","METERINGPOINT")
						
						'Physical Details
						 vTypeOfMP 						= RemoveKeywords(GetRecord_Dict.Item(Ucase("TypeOfMP")))
						 vPhysicalMeteringPoint 		= RemoveKeywords(GetRecord_Dict.Item(Ucase("PhysicalMeteringPoint")))
						 vMeteringGridAreaID 			= RemoveKeywords(GetRecord_Dict.Item(Ucase("MeteringGridAreaID")))
						 vPhysicalStatusOfMP 			= RemoveKeywords(GetRecord_Dict.Item(Ucase("PhysicalStatusOfMP")))
						 vNetSettlementGroup 			= RemoveKeywords(GetRecord_Dict.Item(Ucase("NetSettlementGroup")))
						 vConsumerCategory	 			= RemoveKeywords(GetRecord_Dict.Item(Ucase("ConsumerCategory")))
						 vFromGridAreaID			 	= RemoveKeywords(GetRecord_Dict.Item(Ucase("FromGridAreaID")))
						 vToGridAreaID					= RemoveKeywords(GetRecord_Dict.Item(Ucase("ToGridAreaID")))
						 vPowerPlantGSRN				= RemoveKeywords(GetRecord_Dict.Item(Ucase("PowerPlantGSRN")))
						 vFuelType						= RemoveKeywords(GetRecord_Dict.Item(Ucase("FuelType")))
						 vPSO_Exempt					= RemoveKeywords(GetRecord_Dict.Item(Ucase("PSO_Exempt")))
						 vMP_SubType					= RemoveKeywords(GetRecord_Dict.Item(Ucase("MP_SubType")))
						 vEnergyTimeSeriesMeasureUnit	= RemoveKeywords(GetRecord_Dict.Item(Ucase("EnergyTimeSeriesMeasureUnit")))
						 vProduct						= RemoveKeywords(GetRecord_Dict.Item(Ucase("Product")))
						 
						'Location Detail 
						 vStreetCode					= RemoveKeywords(GetRecord_Dict.Item(Ucase("StreetCode")))						 
						 vStreetName					= RemoveKeywords(GetRecord_Dict.Item(Ucase("StreetName")))
						 vBuildingNumber				= RemoveKeywords(GetRecord_Dict.Item(Ucase("BuildingNumber")))
						 vRoom_ID						= RemoveKeywords(GetRecord_Dict.Item(Ucase("Room_ID")))
						 vFloor_ID						= RemoveKeywords(GetRecord_Dict.Item(Ucase("Floor_ID")))
						 vCitySubDivisionName			= RemoveKeywords(GetRecord_Dict.Item(Ucase("CitySubDivisionName")))
						 vPostCode						= RemoveKeywords(GetRecord_Dict.Item(Ucase("PostCode")))
						 vCityName						= RemoveKeywords(GetRecord_Dict.Item(Ucase("CityName")))
						 vMunicipalityCode				= RemoveKeywords(GetRecord_Dict.Item(Ucase("MunicipalityCode")))						 
						 vCountry						= RemoveKeywords(GetRecord_Dict.Item(Ucase("Country")))
						 
						 
						 'Market Details
						 vFirstConsumerPartyName		= RemoveKeywords(GetRecord_Dict.Item(Ucase("FirstConsumerPartyName")))
						 vFirstConsumerPartyReference	= RemoveKeywords(GetRecord_Dict.Item(Ucase("FirstConsumerPartyReference")))
						 vSettlementMethod				= RemoveKeywords(GetRecord_Dict.Item(Ucase("SettlementMethod")))
						 
						 
						 'Metering Details
						 vMeterReadingOccurrence		= RemoveKeywords(GetRecord_Dict.Item(Ucase("MeterReadingOccurrence")))
						 vEstimatedAnnualVolumeValue	= RemoveKeywords(GetRecord_Dict.Item(Ucase("EstimatedAnnualVolumeValue")))
						 vMPReadingCharacteristics		= RemoveKeywords(GetRecord_Dict.Item(Ucase("MPReadingCharacteristics")))
						 vSubmissionDelay				= RemoveKeywords(GetRecord_Dict.Item(Ucase("SubmissionDelay")))
						 vSMRDate01						= RemoveKeywords(GetRecord_Dict.Item(Ucase("SMRDate01")))
						 vSMRDate02						= RemoveKeywords(GetRecord_Dict.Item(Ucase("SMRDate02")))
						 vSMRDate03						= RemoveKeywords(GetRecord_Dict.Item(Ucase("SMRDate03")))
						 vSMRDate04						= RemoveKeywords(GetRecord_Dict.Item(Ucase("SMRDate04")))
						 vSMRDate05						= RemoveKeywords(GetRecord_Dict.Item(Ucase("SMRDate05")))
						 vSMRDate06						= RemoveKeywords(GetRecord_Dict.Item(Ucase("SMRDate06")))
						 vSMRDate07						= RemoveKeywords(GetRecord_Dict.Item(Ucase("SMRDate07")))
						 vSMRDate08						= RemoveKeywords(GetRecord_Dict.Item(Ucase("SMRDate08")))
						 vSMRDate09						= RemoveKeywords(GetRecord_Dict.Item(Ucase("SMRDate09")))
						 vSMRDate10						= RemoveKeywords(GetRecord_Dict.Item(Ucase("SMRDate10")))
						 vSMRDate11						= RemoveKeywords(GetRecord_Dict.Item(Ucase("SMRDate11")))
						 vSMRDate12						= RemoveKeywords(GetRecord_Dict.Item(Ucase("SMRDate12")))
						 
						 
						 
						
						

						'# View Metering Point						
						If Browser("Datahub").Page("View metering point").Exist(100) Then
													
								Browser("Datahub").Page("View metering point").WebElement("ExpandAllButton").Click	
						End If
						
						
						'Verify whether All tables are displayed.
						With Browser("Datahub").Page("View metering point")
							
							.WebTable("Summary Of MeteringPoint").WebTable_Exist()
							.WebTable("Physical Detail").WebTable_Exist()
							.WebTable("Location Detail").WebTable_Exist()
							.WebTable("Market Details").WebTable_Exist()
							.WebTable("Metering Details").WebTable_Exist()
							
						End With

		
						'Summary Detail	
						With Browser("Datahub").Page("View metering point").WebTable("Summary Of MeteringPoint")
					'		Err.Number = 0 
							.CheckMPDetails "Metering point ID",vMeteringPointID
							.CheckMPDetails "Street name",vStreetName
							.CheckMPDetails "Building number",vBuildingNumber
							.CheckMPDetails "Floor ID",vFloor_ID
							.CheckMPDetails "Postcode ",vPostCode
							.CheckMPDetails "City name",vCityName
							.CheckMPDetails "Type of MP",vTypeOfMP
							.CheckMPDetails "Physical status of MP",vPhysicalStatusOfMP 
							.CheckMPDetails "Settlement method",vSettlementMethod 							
							
						End With	
						
'						If Err.Number = 0 Then
'							CafeReporter "View Metering Point","View Metering Point Summary Detail - Table","Pass","Data within Summary Detail tables are displayed as expected.","Yes"					
'							Else
'							CafeReporter "View Metering Point","View Metering Point Summary Detail - Table","Fail","Data within Summary Detail tables are displayed as expected.","No"																			
'						End If
'						
						
						'Physical Detail
						With Browser("Datahub").Page("View metering point").WebTable("Physical Detail")
					'		Err.Number = 0 
							.CheckMPDetails "Metering point ID",vMeteringPointID
							.CheckMPDetails "Type of MP",vTypeOfMP
							.CheckMPDetails "Physical metering point",vPhysicalMeteringPoint
							.CheckMPDetails "Metering grid area identification",vMeteringGridAreaID		'Commented due to space constraint (seperate logic need to be added to address this issue
							.CheckMPDetails "Net settlement group",vNetSettlementGroup
							.CheckMPDetails "Physical status of MP",vPhysicalStatusOfMP
							.CheckMPDetails "Consumer category",vConsumerCategory
							.CheckMPDetails "Power plant GSRN",vPowerPlantGSRN
							.CheckMPDetails "Fuel type",vFuelType
							.CheckMPDetails "PSO exempt",vPSO_Exempt
							.CheckMPDetails "From grid area ID",vFromGridAreaID
							.CheckMPDetails "To grid area ID",vToGridAreaID
							.CheckMPDetails "Energy time series measure unit",vEnergyTimeSeriesMeasureUnit
							.CheckMPDetails "Product",vProduct
						End With	
						

						
						
						'Location Detail
						With Browser("Datahub").Page("View metering point").WebTable("Location Detail")
			
							.CheckMPDetails "Metering point ID",vMeteringPointID
							.CheckMPDetails "Street code",vStreetCode
							.CheckMPDetails "Street name",vStreetName
							.CheckMPDetails "Building number",vBuildingNumber
							.CheckMPDetails "Floor ID",vFloor_ID
							.CheckMPDetails "Room ID",vRoom_ID							
							.CheckMPDetails "Postcode",vPostCode
							.CheckMPDetails "City name",vCityName
							.CheckMPDetails "Municipality code",vMunicipalityCode
							.CheckMPDetails "Country name",vCountry
						End With	
						
'
						With Browser("Datahub").Page("View metering point").WebTable("Market Details")
			
							.CheckMPDetails "Metering point ID",vMeteringPointID
							.CheckMPDetails "Settlement method ",vSettlementMethod
							.CheckMPDetails "First consumer party name",vFirstConsumerPartyName
							.CheckMPDetails "First consumer party reference",vFirstConsumerPartyReference
								
						End With	
						

						
						'Metering Detail
						With Browser("Datahub").Page("View metering point").WebTable("Metering Details")
					
							.CheckMPDetails "Metering point ID",vMeteringPointID
							.CheckMPDetails "Meter reading occurrence",vMeterReadingOccurrence
							.CheckMPDetails "Estimated annual volume",vEstimatedAnnualVolumeValue
							.CheckMPDetails "MP reading characteristics",vMPReadingCharacteristics
							.CheckMPDetails "Submission delay",vSubmissionDelay
							
							.CheckMPDetails "Scheduled meter reading date01",vSMRDate01
							.CheckMPDetails "Scheduled meter reading date02",vSMRDate02
							.CheckMPDetails "Scheduled meter reading date03",vSMRDate03
							.CheckMPDetails "Scheduled meter reading date04",vSMRDate04
							.CheckMPDetails "Scheduled meter reading date05",vSMRDate05
							.CheckMPDetails "Scheduled meter reading date06",vSMRDate06
							.CheckMPDetails "Scheduled meter reading date07",vSMRDate07
							.CheckMPDetails "Scheduled meter reading date08",vSMRDate08
							.CheckMPDetails "Scheduled meter reading date09",vSMRDate09
							.CheckMPDetails "Scheduled meter reading date10",vSMRDate10
							.CheckMPDetails "Scheduled meter reading date11",vSMRDate11
							.CheckMPDetails "Scheduled meter reading date12",vSMRDate12
							
							
						End With	
						

						 			
 
 				If Err.Number <> 0 Then
 					CafeReporter "ViewMP","Function Name : ViewMeteringPoint, Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
 				End If	
 

End Function


'************************************************************************************************************************************************
'Function Name: RemoveKeywords()
'Function Desc : Removes the keywords used for CAFE from the variable. 
'Arguments: String StrKey
'Return : String
'Example : 
'	RemoveKeywords("#SELECT--Hourly")
'	RemoveKeywords("#WAIT--Hourly")
'	Pls note - function currently doesnt support keyword beyond 1. We might provide this solution in future
'			   eg: #Click--1||#Set--Username
'                  #Select--1||@logout  	
'Author: Matt
'Created Date : 24/06/14
'Last Edited Date : 
'Modification History:
'************************************************************************************************************************************************


Function RemoveKeywords(StrKeys)

		On Error Resume Next
			 
			If Instr(StrKeys,"--") > 0 Then
			
				   'Code removes the keyword and the parameter
					Strkey = Split(Strkeys,"--")	
					Param = Strkey(1)

			Else

					'Return the value
					 RemoveKeywords = Trim(StrKeys)
					 Exit function

			End If			
		
			
		If Err.Number = 0 Then
			RemoveKeywords = Trim(Param)
			Else
			CafeReporter "RemoveKeywords","Error Number = 1001, Error Description = Error in the function 'RemoveKeywords' input '" & Strkeys &"' validate it.","Fail","",""								
		End If
	
End Function



'************************************************************************************************************************************************
'Function Name: WorkingDay(Dt)
'Function Desc : Returns a working date depending on user input & Template date value from config.xml file
'Arguments: String Date	- Input format is string to support Framework.
'0 =  Current Date
'-1 =  Last working date
'1  =  Next working date
'-n =  Last nth working date, where n is a number.
'n =   Next nth working date, where n is a number.
'moduleID :: parameterID - Retrieves the Date template value from config.xml
'Return : Date 
'Example : WorkingDay("0") , WorkingDay("-15") , WorkingDay("-1"), WorkingDay("ISCALC::EFF_DT_SPLMP")
'Author: Matt
'Created Date : 03/07/14
'Last Edited Date : 
'Modification History:
'************************************************************************************************************************************************


Function WorkingDay(Dt)


'***********	Requirement for this function	****************
'Current Date(0) - could be a weekend and could be a holiday.
'Last Working Date(-1) - Shouldnt be a weekend & Shouldnt be a holiday
'Next Working Date(1) - Shouldnt be a weekend & Shouldnt be a holiday
'Last working date (PAST) - Should be n days passed the current working date. Counter starts from D-1, where D is current day.
'				           Holiday are not considered as working days.
'Next Working date (FUTURE) - Same as Last working day, instead of past this feature will be future. Counter starts from D+1, where D is current day.
'
'								eg: Workingday(5). if current date is 31/Jul/14, it would return 8/aug/14.
'									
'****************************************************************
On Error Resume Next

	
					'1.0 Data Declaration	
					Date_Flag = false
					User_SpDt = Cint(Trim(Dt))
					Arr_KnownDt = Array("0","-1","1")
					Cdt = Null
					
					
					'2.0 Initial Data Check for classification 
					'2.0.1		0, -1,1,-n,n
					For i = 0 To uBound(Arr_KnownDt)
							If Strcomp(Trim(Dt),Arr_KnownDt(i)) = 0 Then																	
									Cdt = Dt						
									Exit For
							End If						
					Next
					
					'2.0.2 	Refer Date template from config.XML
					If Instr(1,Dt,"::") Then
							WorkingDay = getDt_XML(Dt)																
							Exit Function	
					End If					
					
					'2.0.3 		Past or Future 
					If isNull(Cdt) Then
						If Instr(1,Dt,"-") > 0 Then
							Cdt = "PAST"
							Else
							Cdt = "FUTURE"
						End If
					End If
					
			
							
				
				Select Case Cdt
					
					Case "0"		'Current Date
							 
							WorkingDay = Date
							 
			
							
					Case "-1"		'Last Working Date
			
							udate = dateAdd("d",User_SpDt,Date)	
							 
							Do
									If IsWorkingDay(udate)= True and IsWeekend(udate) = False Then
											WorkingDay = udate
											Date_Flag = True
										Else
											User_SpDt = User_SpDt -1
											udate = dateAdd("d",User_SpDt,Date)
									End If
									
							Loop While Date_Flag = False
			
			
					Case "1"	'Next Working Date
						
							udate = dateAdd("d",User_SpDt,Date)	
							 
							Do
									If IsWorkingDay(udate)= True and IsWeekend(udate) = False Then
											WorkingDay = udate
											Date_Flag = True
										Else
											User_SpDt = User_SpDt +1
											udate = dateAdd("d",User_SpDt,Date)
									End If
									
							Loop While Date_Flag = False
			
			
					Case "PAST"		'Last nth working date
					
							vDt = Split(dt,"-",2)		' Converting Dt = -15 as Vdt(0) = "-" and vDt(1) = "15"
							
							vTill = Cint(Trim(VDt(1))) 'Converting it to an integer.	
					
							
							udate = dateAdd("d",-1,Date)	'Date starts from yesteday (D-1)
							Counter = 0 ' Counter for working days
							User_SpDt = 0 
							Do
									If IsWeekend(udate) = False and IsWorkingDay(udate) = True Then
											Counter = Counter + 1
											User_SpDt = User_SpDt -1
											udate = dateAdd("d",User_SpDt,Date)
											Else
											User_SpDt = User_SpDt -1
											udate = dateAdd("d",User_SpDt,Date)
									End If						
							Loop While Counter < vTill+1
							
							'After counter 15, date is reduced further. To Compensate it, one date is added. 
							WorkingDay = dateAdd("d",1,udate) 'Return
							
					Case "FUTURE"		'Next nth working date
						
							vTill = Cint(Trim(Dt))
							
							udate = dateAdd("d",1,Date)		'Date calc starts from tomorrow (D+1)
							Counter = 0 ' Counter for working days
							User_SpDt = 0 
							Do
									If IsWeekend(udate) = False and IsWorkingDay(udate) = True Then
											Counter = Counter + 1
											User_SpDt = User_SpDt +1
											udate = dateAdd("d",User_SpDt,Date)
											Else
											User_SpDt = User_SpDt +1
											udate = dateAdd("d",User_SpDt,Date)
									End If						
							Loop While Counter < vTill+2	' We need n+1 days so the counter is increased by 2.
							
							'After counter 15, date is reduced further. To Compensate it, one date is reduced. 
							WorkingDay = dateAdd("d",-1,udate) 'Return		
							
			
					
				End Select
	
				If Err.Number <> 0 Then								
					CafeReporter "WorkingDay","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
				End If
	
	
	
End Function


'************************************************************************************************************************************************
'Function Name: IsWeekend(Dt)
'Function Desc : The function validate whether the given date is weekend.
'Arguments: Date
'Return : True - weekend
'		  False - If not.
'Example : IsWeekend(06/30/14)
'Author: Matt
'Created Date : 03/07/14
'Last Edited Date : 
'Modification History:
'************************************************************************************************************************************************

Function IsWeekend(Dt)

		On Error Resume Next

				Dy = Weekday(Dt,1)	'Week starts with Sunday
				
				Select Case Dy
					
					Case 1	'Sunday
						IsWeekend = True	
					Case 7	'Saturday
						IsWeekend = True
					Case Else	
						IsWeekend = False
					
				End Select	

		If Err.Number <> 0 Then								
					CafeReporter "IsWeekend","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
		End If

	
End Function

'************************************************************************************************************************************************
'Function Name: IsWorkingDay(Dt)
'Function Desc : The function validate whether the given date is working date, by cross verifying the calendar xml file in DataDictionary folder.
'Arguments: Date
'Return : True - working day
'		  False - If not.
'Example : IsWorkingDay(06/30/14)
'Author: Matt
'Created Date : 03/07/14
'Last Edited Date : 
'Modification History:
'************************************************************************************************************************************************


Function IsWorkingDay(Dt)
	
				On Error Resume Next
										
										'1.0	DATA
										
										vfileName = GetXML("DATAHUB","ENDK_HOLIDAY_CALENDAR")
										vXML_path = vLocalPath & "\DataDictionary\" &  vfileName
										
										'2.0	LOGIC									
										
										Dy = Day(Dt)
										Mnth = Month(Dt)
										

										Set oFSO = CreateObject("Scripting.FileSystemObject")
										If oFSO.FileExists(Trim(vXML_path)) Then
														Set oXML = CreateObject("Microsoft.XMLDOM")
														oXML.Load (Trim(vXML_path))

														'3.0 XML QUERY
														Set oNodes = oXML.SelectNodes("/TABLE/HOLIDAYS/ROW[@Month='" & UCase(Trim(Mnth)) & "' and @Date='" & UCase(Trim(Dy)) & "']/text()")

														If oNodes.Length = 0 Then
																	IsWorkingDay = True	 'Yes - working day
															Else
																	IsWorkingDay = False 'Nope
														End If
														Set oNodes = Nothing
														Set oXML = Nothing

														
										Else
														'ERROR FLAG 
														Err.Number = "1100"
														Err.Description = "ERR1100: Holiday xml file does not Exist or file was corrupt"
										End If
										Set oFSO=Nothing


			If Err.Number <> 0 Then								
					CafeReporter "IsWorkingDay","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
			End If
	
End Function


'************************************************************************************************************************************************
'Function Name: ViewBusiness_Transaction()
'Function Desc : Validates the Effectuation Dt and status set in the 'Business Transaction' tab in View MP page.
'Arguments: Nil
'Return : Nil
'Example : ViewBusiness_Transaction()
'Author: Matt
'Created Date : 07/07/14
'Last Edited Date : 
'Modification History:
'************************************************************************************************************************************************
	


Function ViewBusiness_Transaction()


		On Error Resume Next
				 
				EV_Eff_dt = Replace(Environment.Value("Effectuation_Dt"),"-","/")
				
				Exp_status = GetXML("VIEW_MP","BUSINESS_TRANSACTION_STATUS")
				
				Browser("Datahub").Page("View metering point").Link("Business transactions").Click
				
				'Get Effectuation Date
				Set oTable = Browser("Datahub").Page("View metering point").WebTable("Business Transactions")

				If oTable.Exist  Then		'and oTable.Rowcount = 2	- Removed this variable since some MP has many entries. Now the table is made unique with html ID.
				
								vEffectuationDt = oTable.GetCellData(2,3)
								vStatus 		= oTable.GetCellData(2,5)
								
								If StrComp(Trim(EV_Eff_dt),Trim(vEffectuationDt),1) = 0 Then	'Validate the Effectuation Date
									CafeReporter "ViewBusniess_Transaction","View Metering Point Business Transaction Page","Pass","Business Transaction: Effectuation date '" & vEffectuationDt &"' was set as expected","Yes"					
									Else
									CafeReporter "ViewBusniess_Transaction","View Metering Point Business Transaction Page","Fail","Business Transaction: Effectuation date was set as expected","No. Expected Date: " & Environment.Value("Effectuation_Dt") & ", Actual Date: " & vEffectuationDt							
								End If
								
								If StrComp(Trim(Exp_status),Trim(vStatus),1) = 0 Then	' Validate the status
									CafeReporter "ViewBusniess_Transaction","View Metering Point Business Transaction Page","Pass","Business Transaction: Metering Point status was '" & vStatus &"' as expected","Yes"					
									Else
									CafeReporter "ViewBusniess_Transaction","View Metering Point Business Transaction Page","Fail","Business Transaction: Metering Point status was '" & vStatus &"' as expected","No. Expected Status: " & Exp_status & ", Actual Status: " & vStatus
								End If
					Else
					
								CafeReporter "ViewBusniess_Transaction","View Metering Point Business Transaction Page","Fail","Business Transaction table should be visible with details","No the table is not available/visible for logged in user."
					
					
				End If
				
				If Err.Number <> 0 Then
						CafeReporter "ViewBusiness_Transaction","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
				End If


End Function


'************************************************************************************************************************************************
'Function Name: SearchMP_ResultTable()
'Function Desc : Validate the search count.   //Currently it validate only for zero record.//
'Arguments: Nil
'Return : Nil
'Example : SearchMP_ResultTable
'Author: Matt
'Created Date : 07/07/14
'Last Edited Date : 
'Modification History:
'************************************************************************************************************************************************



Function SearchMP_ResultTable(Byval RecordCnt)

		On Error Resume Next

						Set oTable = Browser("Datahub").Page("Search metering point").WebTable("Result")

	
						If oTable.Exist Then
		
							gText = oTable.GetCellData(1,1)
							exp_msg = Trim(RecordCnt) & " results"
		
							If Strcomp(Trim(gText),exp_msg,1) = 0 Then
								CafeReporter "Search Metering Point","Search Metering Point - Result","Pass","'" & gText & "' were found as expected","Yes"								
								Else
								CafeReporter "Search Metering Point","Search Metering Point - Result","Fail","'" & gText & "' were found as expected","No. More than one record are found."
							End If
							
							Else
							
							CafeReporter "Search Metering Point","Search Metering Point - Result","Fail","Search Record table not visible","Yes"
							
						End If
	
				If Err.Number <> 0 Then
						CafeReporter "SearchMP_ResultTable","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
				End If

	
End Function

'************************************************************************************************************************************************
'Function Name: ViewMP_Actions(ByVal StrAction)
'Function Desc : Function click the Action webelement within the 'View MeteringPoint' page.
'Arguments: String Action name.
'	eg:			CORRECT_MOVE-IN ,UPDATE_SPECIAL_MP, GENERATE_WEB_ACCESS_CODE, EDIT_HISTORICAL_STATES
'Return : Nil
'Example : ViewMP_Actions("Update_Special_MP")
'Author: Matt
'Created Date : 08/07/14
'Last Edited Date : 
'Modification History:
'************************************************************************************************************************************************



Function ViewMP_Actions(ByVal StrAction)
	
			On Error Resume Next
	
			
			Set oViewMP = Browser("Datahub").Page("View metering point")
			
	
			Select Case Ucase(Trim(StrAction))
				
						Case "CORRECT_MOVE-IN" '< currently not part of automation scope>
						
									
						Case "SUBMISSION_OF_MASTER_DATA"			
									oViewMP.WebElement("Submission of master data").Click
									SCR_SubmissionOfMasterData()
						
						Case "UPDATE_SPECIAL_MP"		
									oViewMP.WebElement("Update special MP").Click
						
						
						Case "GENERATE_WEB_ACCESS_CODE" ''< currently not part of automation scope>
									
						
						Case "EDIT_HISTORICAL_STATES" '< currently not part of automation scope>
						
									
						Case "MOVE-IN"
									oViewMP.WebElement("Move-in").Click
									FRM_MoveIn()	
						
						Case "SUBMIT_METERED_DATA"
									oViewMP.WebElement("Submit Metered Data").Click	
									FRM_SubmitMeteredData()
						Case "CHANGE_SUPPLIER"
									oViewMP.WebElement("Change supplier").Click	
									FRM_ChangeSupplier()				
				
			    End Select
	
	
				If Err.Number <> 0 Then
						CafeReporter "ViewMP_Actions","Function Name = ViewMP_Actions, Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
				End If
	
	
End Function



'************************************************************************************************************************************************
'Function Name: USplMP_SetEffectuation(Byval Dt, ByVal Msg)
'Function Desc : Function handles the pop window, displayed after updating MP. Set the user defined Effectuation date and confirms the MP is successfully created.
'Arguments: String Dt
'			String Msg - Success / Err
'Return : Nil
'Example : USplMP_SetEffectuation("-1","Success")
'Author: Matt
'Created Date : 08/07/14
'Last Edited Date : 
'Modification History:
'************************************************************************************************************************************************
	
	
	
Function USplMP_SetEffectuation(Byval Dt, Byval vMsg)
	
	
	On Error Resume Next
	
			   'PopUp Message Window
				If Browser("Datahub").Page("Update special metering").Frame("UpdateSpecialMP").Exist(100) Then
					CafeReporter "CSplMP_ConfCreation","Create Special Metering Point","Pass","Pop up screen 'Create Metering Point(master Data) displayed","Displayed"					
					Else	
					CafeReporter "CSplMP_ConfCreation","Create Special Metering Point","Fail","Pop up screen 'Create Metering Point(master Data) displayed","Displayed"					
				End If

				
				'Get EffectuationDate
				 Environment.Value("Effectuation_Dt") = WorkingDay(Trim(Dt))	
				 
				 'Set Effectuation Date & Submit
				 Browser("Datahub").Page("Update special metering").Frame("UpdateSpecialMP").WebEdit("EffectuationDate").Set Trim(Replace(Environment.Value("Effectuation_Dt"),"-","/"))	
				 Browser("Datahub").Page("Update special metering").Frame("UpdateSpecialMP").WebElement("SubmitDHButton").Click
				 


			    Select Case Ucase(Trim(vMsg))
					
					Case "SUCCESS"
								If Browser("Datahub").Page("Update special metering").WebElement("SuccessMsgLabel").WaitProperty("visible",True,15000) Then
									'Success Message Verification
									vMsg = Browser("Datahub").Page("Update special metering").WebElement("SuccessMsgLabel").GetROProperty("innertext")				
									vSuccessMsg = GetXML("CREATE_SPLMP","SUCCESS_MSG")								
									Else
									vMsg = "Error. Object is not visible"
									CafeReporter "CSplMP_ConfCreation","Create Special Metering Point","Fail","Metering Point has been created successfuly","Failed"					
								End If
							    
								
								
								If StrComp(vMsg,vSuccessMsg,1) = 0 Then
									CafeReporter "CSplMP_ConfCreation","Create Special Metering Point","Pass","Metering Point has been created successfuly","Created"					
									Else	
									CafeReporter "CSplMP_ConfCreation","Create Special Metering Point","Fail","Metering Point has been created successfuly","Failed"					
								End If
			

					Case "ERR"
					
							Dt_Mentioned_Err = DateAdd("d",-1,Environment.Value("Effectuation_Dt"))

							'**********************			Change format from dd-mm-yyyy to yyyy-mm-dd		***********************
							
							yyyy = Year(Dt_Mentioned_Err) 
							mm   = Month(Dt_Mentioned_Err) 
							dd	 = Day(Dt_Mentioned_Err)
							
							
							If Len(mm) < 2Then	
								mm = "0" & mm
							End If
							
							If Len(dd) < 2Then	
								dd = "0" & dd
							End If
							
							StrEffDt = trim(yyyy) & "-" & Trim(mm) &"-"& Trim(dd)
							
							'**********************************************************************************************************
							
							
							vErrMsg = Browser("Datahub").Page("Update special metering").Frame("UpdateSpecialMP").WebElement("Rejection_ErrMsg").GetROProperty("innertext")	'Actual Error message
							
							
							Exp_Err_Msg = GetXML("UPDATE_SPLMP","ERR_MSG") 	'Expected Error Msg
							
							
							Exp_Err_Msg = Replace(Exp_Err_Msg,"[MP]",Environment.Value("MeteringPoint"))	'Replacing the tag D, with effectuation date.
							
							
							
							If Strcomp(Trim(vErrMsg),Trim(Exp_Err_Msg),1) = 0 Then
									CafeReporter "USplMP_ConfCreation","Update Special Metering Point","Pass","Expected Error Message '" & Exp_Err_Msg &"' was displayed.","Yes"					
								Else
									CafeReporter "USplMP_ConfCreation","Update Special Metering Point","Pass","Expected Error Message was displayed.","No. Expected Message = '" & Exp_Err_Msg & "', Actual Msg =' " & vErrMsg &"'"					
							End If
							
							'Click the Cancel Button in the Popup window
							Browser("Datahub").Page("Update special metering").Frame("UpdateSpecialMP").WebElement("CancelDHButton").Click
							
	
					Case Else
							CafeReporter "USplMP_SetEffectuation","Incorrect Paramenter","FAIL","ERR Number: 2001, ERR Description: Incorrect parameter for the function'USplMP_SetEffectuation'","Expected paramenter for 'MSG' is either Success/Err"					
					
				 End Select
				
				
	
	
		If Err.Number <> 0 Then
			CafeReporter "USplMP_SetEffectuation","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
		End If
	
	
	
End Function




'************************************************************************************************************************************************
'Function Name: ViewMP_ValidateFields()
'Function Desc : Function handles spl verification of certain fields in View Metering Point page.
'Arguments: Nil
'Return : Nil
'Example : viewMP_ValidateFields()
'Author: Matt
'Created Date : 15/07/14
'Last Edited Date : 
'Modification History:
'************************************************************************************************************************************************
	


Function ViewMP_ValidateFields()


		On Error Resume Next

						'1.0 Data Dictionary						
						 DataDictionary("ViewMP_ValidateFields")
						 
						 vMeteringPoint							= Trim(Ddict.Item(Ucase("MeteringPoint")))
						 vPhysicalStatusMP						= Trim(Ddict.Item(Ucase("PhysicalStatusMP")))
						 vEnergyTimeSeries 						= Trim(Ddict.Item(Ucase("EnergyTimeSeries")))
						 vProduct 								= Trim(Ddict.Item(Ucase("Product")))
						 vConsumption_Overrun_Allowed 			= Trim(Ddict.Item(Ucase("Consumption_Overrun_Allowed")))
						 vFirstConsumer_PartyRef 				= Trim(Ddict.Item(Ucase("FirstConsumer_PartyRef")))
						 
						 
						 '2.0 Get MeteringPoint
						 
						 If Instr(1,vMeteringPoint,"@") > 0 Then		
								vMeteringPoint = Replace(vMeteringPoint,"@","") 'Technique is used to get value from the config file using @GetXML("moduleID","parameterID")
								vMeteringPoint = Eval(Trim(vMeteringPoint))
								
								ElseIf Strcomp(Trim(vMeteringPoint),"REF_MP",1) = 0 Then		'Refers run time Metering point value
						 				vMP = Environment.Value("MeteringPoint")
						 				vMeteringPoint = Replace(vMeteringPoint,"REF_MP",vMP,1)
						 End If

						 
						 '3.0 Code
					
						'# View Metering Point						
						If Browser("Datahub").Page("View metering point").Exist(100) Then							
								Browser("Datahub").Page("View metering point").WebElement("ExpandAllButton").Click	
						End If
						
						'Physical Detail
						With Browser("Datahub").Page("View metering point").WebTable("Physical Detail")
							.CheckMPDetails "Metering point ID",vMeteringPoint
							.CheckMPDetails "Physical status of MP",vPhysicalStatusMP
							.CheckMPDetails "Energy time series measure unit",vEnergyTimeSeries
							.CheckMPDetails "Product",vProduct
						End With	
						
						
					    'Market Detail
						With Browser("Datahub").Page("View metering point").WebTable("Market Details")							
						End With	
						
					    'Metering Detail
						With Browser("Datahub").Page("View metering point").WebTable("Metering Details")
							Err.Number = 0 
							.CheckMPDetails "Consumption overrun allowed ",vConsumption_Overrun_Allowed
						End With	
						
						
						If Err.Number <> 0 Then								
								CafeReporter "viewMP_ValidateFields","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
						End If
						
	
	
End Function


						
 '************************************************************************************************************************************************
'Function Name: CheckMPDetails(ByRef obj, ByVal vColName, ByVal RowVal)
'Function Desc : Compare the row value in the View Metering Point tables. 
'Arguments: byRef obj, String ColumnName, String RowValue
'Return : Nill
'Example : CheckMPDetails("From Grid","Netområde 802(802)")
'Author: Matt
'Created Date : 17/07/14
'Last Edited Date : 
'Modification History:
'************************************************************************************************************************************************


Function CheckMPDetails(ByRef obj, ByVal vColName, ByVal RowVal)
	
	On Error Resume Next
					
					If IsNull(RowVal) or IsEmpty(RowVal) or RowVal = "" or RowVal = " " Then	'Exit function if parameter is null.						
						Exit Function						
					End If	
					
					
					
					'Get Table Name
					vtableName = obj.GetTOProperty("TestObjName")
					
					
					For i = 1 To obj.RowCount
					
						If Strcomp(Trim(vColName),Trim(obj.GetCellData(i,1)),1) = 0 Then
							RowNumber  = i
							Exit For
							Else
							If i = Obj.RowCount Then
								'CafeReporter "CheckMPDetails","In Table: " & vtableName & ", Column: '" & vColName & ".","Fail","Column '"  & vColName & "' should be found within this table.","Not found"
								Exit Function
							End If							
						End If
						
					Next
	 
					CellVal = Obj.GetCellData(Trim(RowNumber),2)
					ColVal =  Obj.GetCellData(Trim(RowNumber),1)
					
					
					GridArea_Fields = ARRAY("METERING GRID AREA IDENTIFICATION","FROM GRID","TO GRID")
					
					
					
					Select Case UCASE(Trim(ColVal))
						
						
							Case "METERING GRID AREA IDENTIFICATION"
							
									If Instr(1,Trim(RowVal),Trim(CellVal),1) > 0 Then
										CafeReporter "CheckMPDetails","View Metering Point, Table : " & vtableName ,"Pass","Details mentioned in '" & Trim(ColVal) & "' is as expected.","Yes"					
										Else
										CafeReporter "CheckMPDetails","View Metering Point, Table : " & vtableName ,"Fail","Details mentioned in '" & Trim(ColVal) & "' is as expected.","Nope. Expected Value = '" & Trim(RowVal) &"', Actual Value = '"  & Trim(CellVal) &"'"					
										Err.Number = 2000
										Err.Description = "View Metering Point, Failure in data comparison. Table : " & vtableName
									End If	
							
							Case "FROM GRID AREA ID"
							
									If Instr(1,Trim(RowVal),Trim(CellVal),1) > 0 Then
										CafeReporter "CheckMPDetails","View Metering Point, Table : " & vtableName ,"Pass","Details mentioned in '" & Trim(ColVal) & "' is as expected.","Yes"					
										Else
										CafeReporter "CheckMPDetails","View Metering Point, Table : " & vtableName ,"Fail","Details mentioned in '" & Trim(ColVal) & "' is as expected.","Nope. Expected Value = '" & Trim(RowVal) &"', Actual Value = '"  & Trim(CellVal) &"'"					
										Err.Number = 2000
										Err.Description = "View Metering Point, Failure in data comparison. Table : " & vtableName
									End If	
							
							
							
							Case "TO GRID AREA ID"							
							
									If Instr(1,Trim(RowVal),Trim(CellVal),1) > 0 Then
										CafeReporter "CheckMPDetails","View Metering Point, Table : " & vtableName ,"Pass","Details mentioned in '" & Trim(ColVal) & "' is as expected.","Yes"					
										Else
										CafeReporter "CheckMPDetails","View Metering Point, Table : " & vtableName ,"Fail","Details mentioned in '" & Trim(ColVal) & "' is as expected.","Nope. Expected Value = '" & Trim(RowVal) &"', Actual Value = '"  & Trim(CellVal) &"'"					
										Err.Number = 2000
										Err.Description = "View Metering Point, Failure in data comparison. Table : " & vtableName
									End If		
							
							
							Case "FIRST CONSUMER PARTY REFERENCE"
							
									RowVal = CDate_ddMonthYYYY(RowVal)
						
								   If Strcomp(Trim(RowVal),Trim(CellVal),1) = 0 Then
										CafeReporter "CheckMPDetails","View Metering Point, Table : " & vtableName ,"Pass","Details mentioned in '" & Trim(ColVal) & "' is as expected.","Yes"					
										Else
										CafeReporter "CheckMPDetails","View Metering Point, Table : " & vtableName ,"Fail","Details mentioned in '" & Trim(ColVal) & "' is as expected.","Nope. Expected Value = '" & Trim(RowVal) &"', Actual Value = '"  & Trim(CellVal) &"'"					
										Err.Number = 2000
										Err.Description = "View Metering Point, Failure in data comparison. Table : " & vtableName
									End If	
						
						
							Case Else

									If Strcomp(Trim(RowVal),Trim(CellVal),1) = 0 Then
										CafeReporter "CheckMPDetails","View Metering Point, Table : " & vtableName ,"Pass","Details mentioned in '" & Trim(ColVal) & "' is as expected.","Yes"					
										Else
										CafeReporter "CheckMPDetails","View Metering Point, Table : " & vtableName ,"Fail","Details mentioned in '" & Trim(ColVal) & "' is as expected.","Nope. Expected Value = '" & Trim(RowVal) &"', Actual Value = '"  & Trim(CellVal) &"'"					
										Err.Number = 2000
										Err.Description = "View Metering Point, Failure in data comparison. Table : " & vtableName
									End If		
					
						
					End Select
					
					
					If Err.Number <> 0 Then								
								CafeReporter "CheckMPDetails","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
					End If
		
	
	
		
End Function
						
						

 '************************************************************************************************************************************************
'Function Name: CDate_ddMonthYYYY(ByVal StrDt)
'Function Desc : Convert and return Date string as < DD MonthName YYYY >format
'Arguments: String Date
'Return : String 
'Example : CDate_ddMonthYYYY("01/02/1985")
'Author: Matt
'Created Date : 17/07/14
'Last Edited Date : 
'Modification History:
'************************************************************************************************************************************************
 
 
Function CDate_ddMonthYYYY(ByVal StrDt)
		
		On Error Resume Next	
			
			
			dt = CDate(Trim(StrDt))
			
			
			
			'Day
			If len(day(dt)) = 1 Then
				dd = "0" & day(dt)
				else
				dd = day(dt)
			End If
			
			'Month
			Select Case Month(dt)
			
							
							Case 1
									mm = "January"
									
							Case 2
									mm = "February"	
							
							Case 3
									mm = "March"
									
							Case 4
									mm = "April"
									
							Case 5
									mm = "May"
									
							Case 6
									mm = "June"
							
							Case 7
									mm = "July"
									
							Case 8
									mm = "August"
							
							Case 9
									mm = "September"
							
							Case 10
									mm = "October"
									
							Case 11
									mm = "November"
							
							Case 12
									mm = "December"
									
							
			End Select
			
		    'Year
			yyyy = Year(dt)
	
	
			'Return date as dd Month YYYY
			CDate_ddMonthYYYY = dd &" "& mm & " " & yyyy
			
	
		If Err.Number <> 0 Then								
								CafeReporter "CDate_ddMonthYYYY","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
		End If
	
	End Function

'************************************************************************************************************************************************
'Function Name: SearchSysParam_ClickResultByName()
'Function Desc : Select the parameter from the search result table byName used for search.
'Arguments: Nil - Value is taken using the Environment.Value("SystemParam_Name")
'Return : Nil
'Example : SearchSysParam_ClickResultByName()
'Author: Matt
'Created Date : 20/08/14
'************************************************************************************************************************************************

Function SearchSysParam_ClickResultByName()
		
		On Error Resume Next

				With Browser("Datahub").Page("Search system parameter")
				
					If .WbfGrid("SearchResult_Table").Exist Then					
						.Link("SysParameter_Link").SetTOProperty "text",Environment.Value("SystemParam_Name")
						.Link("SysParameter_Link").Engine("#CLICK--2")
						CafeReporter "SearchSysParam_ClickResultByName","Search System Parameter","Pass","Searched parameter should be available in the search result table.","Displayed"	
					Else					
						CafeReporter "SearchSysParam_ClickResultByName","Search System Parameter","Fail","Searched parameter should be available in the search result table.","Not Displayed"	
					
					End If
				
				End With
				
				
		If Err.Number <> 0 Then
				CafeReporter "SearchSysParam_ClickResultByName","Function Name = SearchSysParam_ClickResultByName, Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
		End If
	
	
End Function	
	
	
	


'************************************************************************************************************************************************
'Function Name: UpdateMasterData_SetEffectuation(Byval Dt, ByVal Msg)
'Function Desc : Function handles the pop window, displayed after updating MP. Set the user defined Effectuation date and confirms the MP is successfully created.
'Arguments: String Dt
'			String Msg - Success / Err
'Return : Nil
'Example : UpdateMasterData_SetEffectuation("0","Err")
'Author: Matt
'Created Date : 03/09/14
'Last Edited Date : 
'Modification History:
'************************************************************************************************************************************************
	
Function UpdateMasterData_SetEffectuation(Byval Dt, Byval vMsg)
	
	
	On Error Resume Next
	
			   '1.0 PopUp Message Window
				If Browser("Datahub").Page("Edit metering point").Frame("SubmissionOfMasterDataPopUp").Exist(100) Then				
					CafeReporter "UpdateMasterData_SetEffectuation","Update Metering Point","Pass","Pop up screen 'Update Metering Point(master Data) displayed","Displayed"					
					Else	
					CafeReporter "UpdateMasterData_SetEffectuation","Update Special Metering Point","Fail","Pop up screen 'Update Metering Point(master Data) displayed","Not Displayed"					
				End If

							
				
				'2.0 Get New EffectuationDate
				 Environment.Value("Effectuation_Dt") = WorkingDay(Trim(Dt))	
				 
				 'Set Effectuation Date & Submit
				 Browser("Datahub").Page("Edit metering point").Frame("SubmissionOfMasterDataPopUp").WebEdit("EffectuationDate").Set Trim(Replace(Environment.Value("Effectuation_Dt"),"-","/"))	
				 Browser("Datahub").Page("Edit metering point").Frame("SubmissionOfMasterDataPopUp").WebElement("SubmitDHButton").Click

				'3.0	Handle Success/ Failure
			    Select Case Ucase(Trim(vMsg))
					
					Case "SUCCESS"
					
							    'Success Message Verification
							    If Browser("Datahub").Page("View metering point").WebElement("Confirmation_Label").WaitProperty("visible",True,15000) Then
							         vMsg = Browser("Datahub").Page("View metering point").WebElement("Confirmation_Label").GetROProperty("innertext")	
								     vSuccessMsg = GetXML("VIEW_MP","SUCCESS_MSG")	
								     Else
								     vSuccessMsg = "Error. Object is not visible"								     
								     CafeReporter "UpdateMasterData_SetEffectuation","Update Metering Point","Fail","Metering Point has been updated successfuly","Failed"					
							    End If
								
								
								If StrComp(vMsg,vSuccessMsg,1) = 0 Then
									CafeReporter "UpdateMasterData_SetEffectuation","Update Metering Point","Pass","Metering Point has been updated successfuly","Updated"					
									Else	
									CafeReporter "UpdateMasterData_SetEffectuation","Update Metering Point","Fail","Metering Point has been updated successfuly","Failed"					
								End If
			

					Case "ERR"
					
							Dt_Mentioned_Err = DateAdd("d",-1,Environment.Value("Effectuation_Dt"))

							'**********************			Change format from dd-mm-yyyy to yyyy-mm-dd		***********************
							
							yyyy = Year(Dt_Mentioned_Err) 
							mm   = Month(Dt_Mentioned_Err) 
							dd	 = Day(Dt_Mentioned_Err)
							
							
							If Len(mm) < 2Then	
								mm = "0" & mm
							End If
							
							If Len(dd) < 2Then	
								dd = "0" & dd
							End If
							
							StrEffDt = trim(yyyy) & "-" & Trim(mm) &"-"& Trim(dd)
							
							'**********************************************************************************************************
							
							
							vErrMsg = Browser("Datahub").Page("Create metering point").Frame("CreateMP").WebElement("Rejection_ErrMsg").GetROProperty("innertext")	'Actual Error message
							
							
							Exp_Err_Msg = GetXML("VIEW_MP","Error_MSG") 	'Expected Error Msg
							
							
							Exp_Err_Msg = Replace(Exp_Err_Msg,"[D]",StrEffDt)	'Replacing the tag D, with effectuation date.
							
							
							
							If Strcomp(Trim(vErrMsg),Trim(Exp_Err_Msg),1) = 0 Then
									CafeReporter "UpdateMasterData_SetEffectuation","Update Metering Point","Pass","Expected Error Message '" & Exp_Err_Msg &"' was displayed.","Yes"					
								Else
									CafeReporter "UpdateMasterData_SetEffectuation","Update Metering Point","Pass","Expected Error Message was displayed.","No. Expected Message = '" & Exp_Err_Msg & "', Actual Msg =' " & vErrMsg &"'"					
							End If
	
					Case Else
							CafeReporter "UpdateMasterData_SetEffectuation","Incorrect Paramenter","FAIL","ERR Number: 2001, ERR Description: Incorrect parameter for the function'UpdateMasterData_SetEffectuation'","Expected paramenter for 'MSG' is either Success/Err"					
					
				 End Select
		
	
		If Err.Number <> 0 Then
			CafeReporter "UpdateMasterData_SetEffectuation","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
		End If
	
	
	
End Function	



'************************************************************************************************************************************************
'Function Name: FRM_MoveIn()
'Function Desc : Edit MOVE-In details for the MP.
'Arguments: Uses Cafe framework
'Return : Nil
'Example : FRM_MoveIn()
'Author: Matt
'Created Date : 28/08/14
'************************************************************************************************************************************************

Public Function FRM_MoveIn()

				On Error Resume Next
						'1.0 DATA DICTIONARY
						 DataDictionary("FRM_MoveIn")
						 
						 vEffectuationDate 					= Trim(Ddict.Item(Ucase("EffectuationDate")))						 
						 vBalanceResponsibleParty 			= Trim(Ddict.Item(Ucase("BalanceResponsibleParty")))
						 vCustomerTab						= Trim(Ddict.Item(Ucase("CustomerTab")))
						 vConsumerName 						= Trim(Ddict.Item(Ucase("ConsumerName")))
						 vStreetName 						= Trim(Ddict.Item(Ucase("StreetName")))
						 vPostcode 							= Trim(Ddict.Item(Ucase("Postcode")))
						 vCity 								= Trim(Ddict.Item(Ucase("City")))
						 vSubmitDHButton 					= Trim(Ddict.Item(Ucase("SubmitDHButton")))
						
						 
						 '2.0 FUNCTION CALL		 '<User is directed to this page by clicking the link in the search result>
						 
						 '3.0 CODE							
						 With Browser("Datahub").Page("View metering point").Frame("MoveInBalanceSupplier")	
						 
						 			.WebEdit("EffectuationDate").Engine(vEffectuationDate)
						 			.WebEdit("BalanceResponsibleParty").Engine(vBalanceResponsibleParty)	
						 			.Link("Customer").Engine(vCustomerTab)			'Navigate to Section - customer
						 			.WebEdit("ConsumerName").Engine(vConsumerName)	
						 			.WebEdit("StreetName").Engine(vStreetName)
						 			.WebEdit("Postcode").Engine(vPostcode)
						 			.WebEdit("City").Engine(vCity)						 			
						 			.WebElement("SubmitDHButton").Engine(vSubmitDHButton)						 
						 												
						 End With
						 
				If Err.Number <> 0 Then
					CafeReporter "FRM_MoveIn","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
				End If				
	
End Function

'

'************************************************************************************************************************************************
'Function Name: ViewMP_Confirmation()
'Function Desc : Validate the Success or Error Message displayed by the sytem when updating metering point.
'Arguments: String Result (Result - Success or Error)
'Return : Nil
'Example : ViewMP_Confirmation("Success")
'Author: Matt
'Created Date : 03/09/14
'************************************************************************************************************************************************

Function ViewMP_Confirmation(Result)
	
	
		On Error Resume Next

				If StrComp(Result,"Success",1) = 0 Then
					ExpMsg = GetXML("VIEW_MP","SUCCESS_MSG")
					Else
					ExpMsg = GetXML("VIEW_MP","ERROR_MSG")
				End If
				
				vMsg = Browser("Datahub").Page("View metering point").WebElement("Confirmation_Label").GetROProperty("innertext")
								
				If StrComp(ExpMsg,vMsg,1) = 0 Then
						CafeReporter "ViewMP_Confirmation","View Metering Point","Pass","System displays Green status bar with text '" & Trim(vMsg) & "'","Displayed"					
						Else	
						CafeReporter "ViewMP_Confirmation","View Metering Point","Fail","System displays Green status bar with text '" & Trim(vMsg) & "'","Not Displayed"	
				End If
		
	
		If Err.Number <> 0 Then
					CafeReporter "ViewMP_Confirmation","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
		End If	



End Function


'************************************************************************************************************************************************
'Function Name: FRM_SubmitMeteredData()
'Function Desc : Submit Meter Data details
'Arguments: Uses Cafe framework
'Return : Nil
'Example : FRM_SubmitMeteredData()
'Author: Matt
'Created Date : 04/09/14
'************************************************************************************************************************************************

Public Function FRM_SubmitMeteredData()

				On Error Resume Next
						'1.0 DATA DICTIONARY
						 DataDictionary("FRM_SubmitMeteredData")
						 
						 vMeasureDate 					= Trim(Ddict.Item(Ucase("MeasureDate")))						 
						 vQuantityQuality 				= Trim(Ddict.Item(Ucase("QuantityQuality")))						 
						 vSubmitDHButton 				= Trim(Ddict.Item(Ucase("SubmitDHButton")))
						 vHourGrid						= Trim(Ddict.Item(Ucase("HourGrid")))
						 
						 '2.0 FUNCTION CALL		 '<User is directed to this page by clicking the link in the search result>
						 
						 '3.0 CODE							
						 With Browser("Datahub").Page("View metering point").Frame("Submit MeterData time series")
						 						.WebEdit("MeasureDate").Engine(vMeasureDate)
												.WebEdit("QuantityQuality").Engine(vQuantityQuality)												
												.WebElement("SubmitDHButton").Engine(vSubmitDHButton)	
						 End With
						 
				If Err.Number <> 0 Then
					CafeReporter "FRM_SubmitMeteredData","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
				End If				
	
End Function

'************************************************************************************************************************************************
'Function Name: SetSubmitMD_HourGrid(ByVal HrVal)
'Function Desc : Set the hour reading in 24 fields as per user input.
'Arguments: ByVal String HRVal (value to be set in the reading)
'Return : Nil
'Example : SetSubmitMD_HourGrid("5")	
'Author: Matt
'Created Date : 04/09/14
'************************************************************************************************************************************************
Function SetSubmitMD_HourGrid(ByVal HrVal)
	
		On Error Resume Next
		
			'1.0 Enter detail in the Submit metered Grid
			With Browser("Datahub").Page("View metering point").Frame("Submit MeterData time series").WbfGrid("HourGrid")
						If .Exist(10)	Then		'Sync for Grid to appear
								rowcount = .RowCount
								For i = 2 To rowcount-1
									.SetCellData i,2,Trim(HrVal) 
								Next
								CafeReporter "SetSubmitMD_HourGrid","Submit Metered Data - Hour Reading","Done","Hour Grid was visible, user was able to enter the readings '" & HrVal &"' in all 24 fields.","As expected."					
						Else	
								CafeReporter "SetSubmitMD_HourGrid","Submit Metered Data - Hour Reading","Fail","Hour Grid was visible, user was able to enter the readings '" & HrVal &"' in all 24 fields.","Error - Grid wasnt visible"	
						End If	
						
			End With
			
		If Err.Number <> 0 Then
					CafeReporter "SetSubmitMD_HourGrid","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
		End If		
	
	
End Function


'************************************************************************************************************************************************
'Function Name: ViewMD_ValidateTimeSeries(ByVal Val,ByVal Quan_Qual)
'Function Desc : Validate the hour reading in 24 fields as per user input.
'Arguments: ByVal String Val (value to be set in the reading)
'			ByVal String Quan_Qual
'Return : Nil
'Example : ViewMD_ValidateTimeSeries "5","Measured"
'Author: Matt
'Created Date : 05/09/14
'************************************************************************************************************************************************
	Function ViewMD_ValidateTimeSeries(ByVal Val,ByVal Quan_Qual)

			On Error Resume Next 
	 	 
					Err_Cmp = False 'Flag for Error

	 	 			Dt = GetDt_XML("ISCALC::EFF_DT_SPLMP")		'Get the Period Date
					Dt_chgFormat = Split(dt,"/")
					Dt_YYYYMMDD = Trim(Dt_chgFormat(2)) &"-"& Trim(Dt_chgFormat(1)) &"-"& Trim(Dt_chgFormat(0))		'converting the date format from DD/MM/YYYY to YYYY-MM-DD
	 	 
					Hour_Array = Split(GetXML("ISCALC","Hour_Reading"),",")
	
	
					With Browser("Datahub").Page("View metering data").WebTable("Period")
					
								.Exist(15) 'Sync								
								rcount = .RowCount		'This method adds the row of header and table border to the count by default. So the actual row count of record is "rcount -2"
								
								
								If rcount-2 <> Ubound(Hour_Array)+1 Then		'Validate whether the row counts reflect 24 hours enteries.	
									CafeReporter "ViewMD_ValidateTimeSeries","Submit Metered Data - TimeSeries","Fail","Expected 24 Rows of time series enteries","Actual '" & Trim(rcount) &"' rows of time series are displayed."
								End If								
								
								
								For i = 0 To Ubound(Hour_Array)					
										Ex_period  		= Dt_YYYYMMDD &" "& Trim(Hour_Array(i))				'Expected Values
										Ex_Val	   		= Cdbl(Replace(Trim(Val),".",","))
										Ex_Quan_Qual	= Trim(Quan_Qual)									
																											'Actual Values	
										period 		= Trim(.GetCellData(i+3,1))
										AcVal    	= Cdbl(Replace(Trim(.GetCellData(i+3,2)),".",","))	'To Support Danish Numbering system since OS language is Dansk. Moreover using Double since the value is returned with 3 decimal points.
										Quan_Qlty 	= Trim(.GetCellData(i+3,3))
										
		
										If StrComp(Ex_period,period,0) <> 0 OR Eval(Ex_Val=AcVal) <> True OR Strcomp(Ex_Quan_Qual,Quan_Qlty,1) <> 0  Then																						
											CafeReporter "ViewMD_ValidateTimeSeries","Submit Metered Data - TimeSeries","Fail","Expected Period: " & Ex_period &", Value: '"& Ex_Val &"', Quantity_Quality: '" & Ex_Quan_Qual &"'","Actual Period: " & period &", Value: '"& AcVal &"', Quantity_Quality: '" & Quan_Qlty &"'"												
											Err_Cmp = True 
										End If
								Next
										If Err_Cmp = False Then											
											CafeReporter "ViewMD_ValidateTimeSeries","Submit Metered Data - TimeSeries","Pass","Expected 24 rows of time series enteries with Value: "& Ex_Val &", Quantity_Quality:" & Ex_Quan_Qual,"As expected displayed." 
										End If
								
					End With
	
		
			If Err.Number <> 0 Then
					CafeReporter "ViewMD_ValidateTimeSeries","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
			End If		
	
	End Function






'************************************************************************************************************************************************
'Function Name: ForgPswrd_VerifyErrMsg()
'Function Desc : Clicks on Forget password and sends an email to the email id mentioned 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : ForgPswrd_VerifyErrMsg()
'Author: Supriya
'Created Date : 27/08/14
'Last Edited Date : 
'Modification History:

'************************************************************************************************************************************************


Function ForgPswrd_VerifyErrMsg()
On Error Resume Next 	
					
				If Browser("Datahub").Page("Datahub").WebElement("EmailMsgInstrn").Exist(50) Then	
				
					vErrMsg = Browser("Datahub").Page("Datahub").WebElement("EmailMsgInstrn").GetROProperty("innertext")
					
					CafeReporter "ForgPswrd_VerifyErrMsg","ForgPswrd_VerifyErrMsg ","Pass","Error message is displayed as expected by the system" & vErrMsg,"Yes"						
				 
				Else	
					CafeReporter "ForgPswrd_VerifyErrMsg","ForgPswrd_VerifyErrMsg ","Fail","Error message is displayed as expected by the system","Nope"							
									
				End If




	If Err.Number <> 0 Then
		
			CafeReporter "ForgPswrd_VerifyErrMsg","Function Name :ForgPswrd_VerifyErrMsg, Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""
	End If	
 End Function




'************************************************************************************************************************************************
'Function Name: EmailVerification()
'Function Desc : Verifies the email recieved with the Body, Subject and sender email address
'Arguments: Uses Cafe framework
'Return : Nil
'Example : EmailVerification()
'Author: Matt /Supriya
'Created Date : 12/08/14
'Last Edited Date : 
'Modification History:
'************************************************************************************************************************************************
Function EmailVerification()
	
			On Error Resume Next
			
					'1.0 DATA DICTIONARY
											
					DataDictionary("VerifyEmail")
						 
					vSubject	 			= Trim(Ddict.Item(Ucase("Subject_Verify")))
					vBody			 		= Trim(Ddict.Item(Ucase("Body_Verify")))
					vEmail					= Trim(Ddict.Item(Ucase("Email_From")))
					vVerify					= Trim(Ddict.Item(Ucase("Detail_From_Email")))
					vEmailAccount 			= Trim(Ddict.Item(Ucase("Email_Account")))
									
			
										Wait (30)	'Synchronisation for email - wait
			
										Set oOtl = CreateObject("Outlook.Application")	'Create Outlook Instance
										Set oMap = oOtl.GetNamespace("MAPI")	'get folder access
																									
										
										

										 '************* Get mails from DH_Testauto Mail box  *************                
								         
								        
								         'Create reference to Inbox Folder 							              	  
								              
							              Select Case  oMap.GetDefaultFolder(6).Parent
												Case vEmailAccount   ' project profile 
												  	Set oInb_Items = oMap.GetDefaultFolder(6).Items
												Case Else  ' ' personal profile   
												 	 Set oInb_Items = oMap.Folders(vEmailAccount).Folders("Indbakke").Items	'  'Find all items count  in the Inbox Folder
'																									
										 End Select 
										 
									 	              
'				              
										'Get Last Email 

									 	Set oLastReceivedEmail = oInb_Items.GetLast
									 	print oLastReceivedEmail.Subject
									 	print oLastReceivedEmail.Body
									 	
									 	If not oLastReceivedEmail.SenderName <> "" Then
									 				CafeReporter "GetUserPassword_Email","Recieve Email","Fail","Email received with requested subject and message","Nope"
									 	
											 		Exit Function
									 		
									 	End If 
									 	
																	
							            'Loop through the mail items
							            For i=1 to 20
									 					
									 											 					
														 	If Strcomp(Trim(oLastReceivedEmail.SenderName),vEmail,1) = 0 Then
														 		
														 		'Search Flags
														 		 Email_Received = True 'Email found
																 Subject_AsExpected = False   'Subject as expected
																 Body_AsExpected  = False	'Body of the email as expected										 
														 		
														 		'Verify Subject
														 		 If Strcomp(vSubject,Trim(oLastReceivedEmail.Subject)) = 0 Then
														 		 	Subject_AsExpected = True
																	Else
																	Email_Received = False
														 		 End If
														 		
														 		'Verify Body/content
														 		 If Instr(1,Trim(oLastReceivedEmail.Body), vBody,1) > 0 Then					 		 	
														 		 	Body_AsExpected  = True
														 		 	Else
														 		 	Email_Received = False
														 		 End If					 		 				 		 
														 		
														 	End If	
														 	
														 	
														 	If Subject_AsExpected = True AND Body_AsExpected = True Then
														 		CafeReporter "GetUserPassword_Email","Recieve Email","Pass","Email received with requested subject and message","Yes"
												 		
														 		 Call GetDetail_Email (Trim(oLastReceivedEmail.Body),vVerify)	'Get Detail from email												 		
														 		
														 		Exit For									 	
														 	Else
															 	Set oLastReceivedEmail = oInb_Items.GetPrevious		'Check previous email				 
															 
														 	End If
										 					
										Next	
							
						
					
					
							If Email_Received = False Then		'Report if email has not been received within certain iteration						
								 CafeReporter "EmailVerification","Recieve Email","Fail","Email received with requested subject and message","Nope"						
							End If
	
			 			If Err.Number <> 0 Then
							CafeReporter "EmailVerification","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
						End If  

	
	
End Function
'************************************************************************************************************************************************
'Function Name: GetDetail_Email()
'Function Desc :Gets the password , user and account information   from the  email recieved  
'Arguments: Uses Cafe framework
'Return : Nil
'Example : GetDetail_Email()
'Author: Matt 
'Created Date : 12/08/14
'Last Edited Date : 
'Modification History:

'************************************************************************************************************************************************
Function GetDetail_Email(ByVal EmailContent, ByVal Verify)


		On Error Resume Next


					Select Case Ucase(Trim(Verify))
					
								Case "USER"
											
											'CURRENTLY NOT REQUIRED
								
								Case "PASSWORD"
								
											'2.0		GET PASSWORD DETAILS
											Password_pos1 	 	= 	Instr(1,EmailContent,"generated:",1)
											Password_pos2	 	= 	Instr(Password_pos1,EmailContent,"You",1)
					
											Password 		  	= 	Trim( 	mid (EmailContent,Password_pos1,Password_pos2 - Password_pos1))
											Password		  	= 	RemoveNewLine(Password) 			'Remove newline, carriage returns, spaces
					
											Password 			= 	Split(Password,":")				
											vPass 				= 	trim(Password(1))		'Get password detail		
											SetXML "Forgot","password",vPass	'set password value in config xml
								
								
								Case "ACCOUNT"
											
											'1.0		GET USER DETAILS
											UserName_pos1 	= 	Instr(1,EmailContent,"Username",1)
											UserName_pos2 	= 	Instr(UserName_pos1,EmailContent,"Password",1)
					
											UserName		 	= 	Trim(	mid(EmailContent,UserName_pos1,UserName_pos2 - UserName_pos1))									
											UserName		 	= 	RemoveNewLine(UserName) 			'Remove newline, carriage returns, spaces
					
											UserName 			= 	Split(Username,":")					
											vUser 				= 	trim(UserName(1))		'Get User details	
  										
											SetXML "EMAIL","USERNAME", vUser	'set user value in config xml
					
											'2.0		GET PASSWORD DETAILS
											Password_pos1 	 	= 	Instr(1,EmailContent,"Password",1)
											Password_pos2	 	= 	Instr(Password_pos1,EmailContent,"This",1)
					
											Password 		  	= 	Trim( 	mid (EmailContent,Password_pos1,Password_pos2 - Password_pos1))
											Password		  	= 	RemoveNewLine(Password) 			'Remove newline, carriage returns, spaces
					
											Password 			= 	Split(Password,":")				
											vPass 				= 	trim(Password(1))		'Get password detail		
											SetXML "EMAIL","PASSWORD",vPass	'set password value in config xml
									Case "CLICKLINK"
										
											strLink = GETXML("EMAIL","LINK")
										print EmailContent
											If  Instr(EmailContent,strLink)  > 0  Then
											SystemUtil.CloseProcessByName("IExplore.exe")
											
												SystemUtil.Run strLink
												 CafeReporter "EmailVerification","Check Link in the  Email","Pass","Email received with requested Link","Yes"	
											Else
												 CafeReporter "EmailVerification","Check Link in the  Email","Fail","Email received with requested Link","Nope"	
											End If									
								
								
								Case Else
						
						
					End Select
		
			If Err.Number <> 0 Then			
						Reporter.ReportEvent micFail,"GetDetail_Email","Error Number = " & Err.number & ", Error Description = " & Err.Description & "."			
			End If		

					


End Function

'************************************************************************************************************************************************
'Function Name: VMP_VerifyMarketDetailsGO()
'Function Desc : Verifies the Column Names of Market Details in Summary Page of' View Metering Point page ' after creating the MP 
 'Arguments: Nil
'Return : Nil
'Example : VMP_VerifyMarketDetailsGO()
'Author: Supriya
'Created Date :19/08/2014  
'Last Edited Date : 
'Modification History:
'
'************************************************************************************************************************************************
Function VMP_VerifyMarketDetailsGO()
	
	On Error Resume  next 
	
	
	
		
						bFound = false
						rwcnt = Browser("Datahub").Page("View metering point").WebTable("Market Details").RowCount 
						For Iterator = 1 To rwcnt Step 1
							
								strCellVal = Browser("Datahub").Page("View metering point").WebTable("Market Details").GetCellData(Iterator,1)
								 																		
									If Instr(Trim(strCellVal),"BalanceSupplierID") > 0 or Instr(Trim(strCellVal),"BalanceSupplierStartDate") > 0 or Instr(Trim(strCellVal),"BalanceResponsiblePartyID") > 0 or Instr(Trim(strCellVal),"BalanceResponsiblePartyStartDate") > 0 or Instr(Trim(strCellVal),"WebAccessCode") > 0 Then 

                               				bFound = True							
									
									End If
														 
						Next


					If bFound Then
						 CafeReporter "VMP_VerifyMarketDetailsGO","VMP_VerifyMarketDetailsGO","fail","  Field should not be visisble with Grid Operator login","Nope"																			
					Else
						CafeReporter "VMP_VerifyMarketDetailsGO","VMP_VerifyMarketDetailsGO","Pass","  Field 'BalanceSupplierID','BalanceSupplierIDate','BalanceResponsiblePartyStartDate','BalanceResponsibleParty'and 'WebAccessCode'  should not be visisble with Grid Operator login","Yes"
					
					End If 
					
					
	If Err.Number <> 0 Then
 					CafeReporter "VMP_VerifyMarketDetailsGO","Function Name : ViewMP, Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
 	End If	

'		
End Function





'************************************************************************************************************************************************
'Function Name: CHIstMP_VerifyPhyStatus(vStatus)
'Function Desc : Verifies the Physical Status in the Summary of Metering point  in the Page 'View Metering Point' 
'Arguments: Nil
'Return : Nil
'Example : CHIstMP_VerifyPhyStatus("Inactive")
'Author: Supriya
'Created Date :19/08/2014  
'Last Edited Date : 
'Modification History:
'
'************************************************************************************************************************************************


Function CHIstMP_VerifyPhyStatus(vStatus)

On Error Resume Next 
							
						If Browser("Datahub").Page("View metering point").Exist(100) Then							
								 	
						
								'Summary Detail	
								With Browser("Datahub").Page("View metering point").WebTable("Summary Of MeteringPoint")
									.CheckMPDetails "Physical status of MP",vStatus
									 													
								End With	
						
							End If
			
				If Err.Number <> 0 Then
					CafeReporter "CHIstMP_VerifyPhyStatus","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""
					
				Else
					Cafereporter  "CHIstMP_VerifyPhyStatus","CHIstMP_VerifyPhyStatus","Pass","Physical Status of MP is as exepected." & vStatus,"Yes"
				End If
End Function


'************************************************************************************************************************************************
'Function Name: CHistMP_ConfCreation()
'Function Desc : Function handles the pop window, displayed after creating historical  MP. Moreover confirms the MP is successfully created.
'Arguments: Nil
'Return : Nil
'Example : CHistMP_ConfCreation()
'Author: Supriya
'Created Date :  
'Last Edited Date : 
'Modification History:
'19/08/2014
'************************************************************************************************************************************************
	
	
	
Function CHistMP_ConfCreation(Byval Dt, Byval vMsg)
	
	
	On Error Resume Next
					 
				'1.0 Check if Pop up window is displayed 
				With Browser("Datahub").Page("Create historical metering").Frame("Create historical metering")
					.Engine("#EXIST--Y ") '|| @REPORT(CHistMP_ConfCreation,Create Historical Metering Point,Pop up screen is displayed)")
	 
					
					
				'2.0 Validate the default Effectuation date.
				
					
					vEffectuationDt = Browser("Datahub").Page("Create historical metering").Frame("Create historical metering").WebEdit("EffectuationDate").GetROProperty("value")
					 If vEffectuationDt <> "" Then
				
					CafeReporter  "CHistMP_ConfCreation","Create Historical Metering Point","Pass","Pop up screen - Default Effectualtion is displayed","Yes"			
					Else	
					CafeReporter "CHistMP_ConfCreation","Create Historical Metering Point","Fail","Pop up screen - Default Effectualtion is displayed  ","Nope"					
					
				   End If					
					
					 
				
				'3.0 Get New EffectuationDate
					 Environment.Value("Effectuation_Dt") = WorkingDay(Trim(Dt))	
				 
				 	'Set Effectuation Date & Submit
				 	.WebEdit("EffectuationDate").Set Trim(Replace(Environment.Value("Effectuation_Dt"),"-","/"))
					CafeReporter  "CHistMP_ConfCreation","Create Historical Metering Point","Pass"," Effectualtion Date set to the Past :: " & Environment.Value("Effectuation_Dt"),"Yes"				 	
				    .WebElement("SubmitDHButton").Click
				 
				End With		
		 			Browser("Datahub").Page("View metering point").WebElement("SuccessMsgLabel").WaitProperty "visible",True,500	'Sync for message to be visible
				    Select Case Ucase(Trim(vMsg))
				    
						
						Case "SUCCESS"
						
								   ' Success Message Verification
									vMsg = Browser("Datahub").Page("View metering point").WebElement("SuccessMsgLabel").GetROProperty("innertext")				
									vSuccessMsg = GetXML("CREATE_SPLMP","SUCCESS_MSG")
									
									
									If StrComp(vMsg,vSuccessMsg,1) = 0 Then
										CafeReporter "CHistMP_ConfCreation","Create Historical Metering Point","Pass","Metering Point has been created successfuly","Created"					
										Else	
										CafeReporter "CHistMP_ConfCreation","Create Historical  Metering Point","Fail","Metering Point has been created successfuly","Failed"					
									End If
						Case Else 	
				
					End Select 
		
		If Err.Number <> 0 Then
			CafeReporter "CHistMP_ConfCreation","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
		End If
	
	
End Function




'************************************************************************************************************************************************
'Function Name: CEditMP_SaveValidSubmitDraft()
'Function Desc : Deletes Existing Historical States for the Historical Metring point 
'Return : Nil
'Example : CEditMP_SaveValidSubmitDraft()
'Author: Supriya
'Created Date : 17/07/14
'Last Edited Date : 
'Modification History:
' Supriya -20/08/2014 
'************************************************************************************************************************************************ 
 
 
 Function CEditMP_SaveValidSubmitDraft()
 
 On Error Resume Next 
 

								'Success Message Verification for Submit Button 
								vMsg = Browser("Datahub").Page("View historical metering").WebElement("SuccessMsgLabel").GetROProperty("innertext")				
								vSuccessMsg = GetXML("CREATE_SPLMP","SUCCESS_MSG")
								
								If StrComp(vMsg,vSuccessMsg,1) = 0 Then
									CafeReporter "CEditMP_SaveValidSubmitDraft","Edit historical Metering Point","Pass","Details should be  Submitted successfully.Success Message ::" &vMsg,"Yes"					
								Else	
									CafeReporter "CEditMP_SaveValidSubmitDraft","Edit historical Metering Point","Fail","Details should be  Submitted successfully","Nope"					
								End If
											
											
											
 	
 								With Browser("Datahub").Page("View historical metering")
 								
 								
										.WebElement("Save draft").Engine("#waittime--10||#CLICK--2")										 
									
										vMsg = Browser("Datahub").Page("View historical metering").WebElement("SuccessMsgLabel").GetROProperty("innertext")	'Success Message Verification			
										vSuccessMsg = GetXML("CREATE_SPLMP","SUCCESS_MSG")
										If Browser("Datahub").Page("View historical metering").WebElement("SuccessMsgLabel").Exist(10) Then
											CafeReporter "CEditMP_SaveValidSubmitDraft","Edit historical Metering Point" ,"Pass","Save Draft is done succesfully.Success Message ::" &vMsg ,"Yes"
										Else			
											CafeReporter "CEditMP_SaveValidSubmitDraft","Edit historical Metering Point" ,"Fail","SaveS Draft is done succesfully","Nope"	
										End If
													 
								  
										
										.WebElement("Validate draft").Engine("#CLICK--2")
										 vMsg = Browser("Datahub").Page("View historical metering").WebElement("SuccessMsgLabel").GetROProperty("innertext")	'Success Message Verification			
										 vSuccessMsg = GetXML("CREATE_SPLMP","SUCCESS_MSG")
										 If Browser("Datahub").Page("View historical metering").WebElement("SuccessMsgLabel").Exist(10) Then
											CafeReporter "CEditMP_SaveValidSubmitDraft","Edit historical Metering Point" ,"Pass","Validate Draft is done succesfully.Success Message ::" &vMsg ,"Yes"
										 Else			
											CafeReporter "CEditMP_SaveValidSubmitDraft","Edit historical Metering Point" ,"Fail","Validate Draft is done succesfully","Nope"	
										 End If
										
										
	 
						 				.WebElement("Submit draft").Engine("#CLICK--2")
						 				 vMsg = Browser("Datahub").Page("View historical metering").WebElement("SuccessMsgLabel").GetROProperty("innertext")'Success Message Verification		
													
										 vSuccessMsg = GetXML("CREATE_SPLMP","SUCCESS_MSG")
										 If Browser("Datahub").Page("View historical metering").WebElement("SuccessMsgLabel").Exist(10) Then
											CafeReporter "CEditMP_SaveValidSubmitDraft","Edit historical Metering Point" ,"Pass","Submit Draft is done succesfully.Success Message ::" &vMsg ,"Yes"
										 Else			
											CafeReporter "CEditMP_SaveValidSubmitDraft","Edit historical Metering Point" ,"Fail","Submit Draft is done succesfully","Nope"	
										 End If
							End With
							
							
							
 	
	If Err.Number = 0  Then							
			CafeReporter "CEditMP_SaveValidSubmitDraft","Validated and Submitted  Draft successfully", "Pass","Draft should be Validated and Saved successfully ","Yes"
	Else						
			CafeReporter "CEditMP_SaveValidSubmitDraft","Validated and Submitted  Draft successfully", "Fail","Draft should be Validated and Saved successfully ","Nope"
    End If
								
 	
 End Function	
   
'************************************************************************************************************************************************
'Function Name: CHistMP_EditCurState()
'Function Desc : Edits the state of the  new  Historical Mp created  
'Return : Nil
'Example : CHistMP_EditCurState()
'Author: Supriya
'Created Date : 20/07/14
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************ 
 Function  CHistMP_EditCurState()
 
 On Error Resume Next 
 
 
 						
 						'1.0	DATA		
						Table     						 			= GetXML("VIEW_MP","TABLE") 'Environment.Value("ScriptID")
						vScriptID								    = GetXML("VIEW_MP","SCRIPT_ID")  'Environment.Value("ScriptID")
						vStep     						 			= GetXML("VIEW_MP","STEP") 'Environment.Value("ScriptID")
						vFirstConsumerPartyReferenceDate 			= Replace(WorkingDay(0),"-","/")
						vBalanceSupplierStartDateInput	 			= Replace(WorkingDay(0),"-","/")
						vBalanceResponsiblePartyStartDateInput  	= Replace(WorkingDay(0),"-","/")
						vPhysicalStatusOfMP 						= Trim(Ddict.Item(Ucase("PhysicalStatusOfMP")))
						vTypeOfMP									= Trim(Ddict.Item(Ucase("TypeOfMP")))						
					    vFirstConsumerPartyName 					= Trim(Ddict.Item(Ucase("FirstConsumerPartyName")))
					    vWebAccessCode 								= Trim(Ddict.Item(Ucase("WebAccessCode")))
					    vBalanceSupplier 							= Trim(Ddict.Item(Ucase("BalanceSupplier")))
					   vBalanceResponsibleParty 					= Trim(Ddict.Item(Ucase("BalanceResponsibleParty")))
						
 				
 						'2.0 Screen
			 				With Browser("Datahub").Page("View metering point")
				 				.Engine("#EXIST--Y")
				 				.WebElement("Edit historical states").Click
			 				End With 
			 		
								'2.1.Edits the current state by filling up the details  First Consumer Party,Balance Supplier,Responsible Party,StartDates								
								With Browser("Datahub").Page("View historical metering")
								.Sync
								.Engine("EXIST--Y")
								.WebElement("Edit").Engine("#CLICK--5")
								End With 
							
							
												
						With Browser("Datahub").Page("Edit historical metering")
									
									.Link("Physical details").Engine("#CLICK--8")
									strPSvalue 			= .WebEdit("PhysicalStatusOfMP").GetRoproperty("default value")
									strTypeofMPvalue 	= .WebEdit("TypeOfMP").GetRoproperty("default value")
									vType = Split(vTypeOfMP,"--")
						 			vTypeOfMP = vType(1)
									 
									.Link("Market details").Engine("#CLICK--10")
									.WebEdit("FirstConsumerPartyName").Engine(vFirstConsumerPartyName)
									.WebEdit("FirstConsumerPartyReferenceDate").Engine(vFirstConsumerPartyReferenceDate)
									.WebEdit("WebAccessCode").Engine(vWebAccessCode)
									.WebEdit("BalanceSupplier").Engine(vBalanceSupplier)	
									.WebEdit("BalanceSupplierStartDateInput").Engine(vBalanceSupplierStartDateInput)						
									.WebEdit("BalanceResponsibleParty").Engine(vBalanceResponsibleParty)
									.WebEdit("BalanceResponsiblePartyStartDateInput").Engine(vBalanceResponsiblePartyStartDateInput)						
									.WebElement("Submit").Engine("#CLICK--10||@CEditMP_SaveValidSubmitDraft()")			
						
						End With
						
						If Err.Number = 0  Then
							
							CafeReporter "CHistMP_EditCurState","Edited the Current state of the newly created MP", "Pass","Edit Current  state should be successful","Yes"

						Else
						
							CafeReporter "CHistMP_EditCurState","Edited the Current state of the newly created MP", "Fail","Edit Current  state should be successful","Nope"	
						End If
															 
 	
 End Function





'************************************************************************************************************************************************
'Function Name: CEditMP_SetValidFromDate()
'Function Desc : Sets the 'Valid From date' which has to be in the past but after the ENd date(Current valid From date displayed)
'Return : Nil
'Example : CEditMP_SetValidFromDate()
'Author: Supriya
'Created Date : 20/08/14
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function CEditMP_SetValidFromDate()

On Error Resume Next 


				strDefaultValidFromDate = Browser("Datahub").Page("Add historical metering").WebEdit("ValidFromDateInput").Getroproperty("default value")
				print strDefaultValidFromDate
				
				If strDefaultValidFromDate <> ""  Then
				
					CafeReporter "CEditMP_SetValidFromDate","Get 'Valid From Date'","Pass","The 'Valid From Date' field  should  have prefilled data ","Yes"
				Else
					CafeReporter "CEditMP_SetValidFromDate","Get 'Valid From Date'","Fail","The 'Valid From Date' field   should  have prefilled data","Nope"		
									
				End If
				
'						 
			     dDate = getDate_DDMMYYYY()
				 DtDiff =  Datediff("d",strDefaultValidFromDate,dDate)
				
				 If DtDiff > 1  Then							 	
				 	cDt = DateAdd("d",1,strDefaultValidFromDate)
				 	CEditMP_SetValidFromDate = Cdate(cDt)
				 	 
				 	
				  
				 	CafeReporter "CEditMP_SetValidFromDate","Check 'Valid From Date' to be Set","Pass","The 'Valid From Date' should be in the past but greater than End Date (prefilled data of the field ).The Date to be Set is :- "& cDt ,"Yes"
				 		
				 Else
									 
				 	 CafeReporter "CEditMP_SetValidFromDate","Check 'Valid From Date' to be Set","Fail","The 'Valid From Date' should be in the past but greater than End Date (prefilled data of the field ) ","Nope.The Valid Froim Date field should have correct date "
				 	
				 End If
							 
'		
				If Err.Number <> 0 Then
					CafeReporter "CEditMP_SetValidFromDate","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
				End If				
						
End Function

'************************************************************************************************************************************************
'Function Name: CEditMP_UnlockMP()
'Function Desc : Unlocks the Mp when its locked while editing 
'Return : Nil
'Example : CEditMP_UnlockMP()
'Author: Supriya
'Created Date : 20/08/14
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************



Function CEditMP_UnlockMP()


On Error Resume Next 
	'1.0 'Unlock the Metering Pont if its locked by a different user 						
			If Browser("Datahub").Page("View historical metering").Frame("Frame").Exist(15) then 
					Browser("Datahub").Page("View historical metering").Frame("Frame").WebElement("Unlock").Click
			End If
			
			If Err.Number <> 0 Then
					CafeReporter "CEditMP_UnlockMP","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
			End If		
	
End Function
'************************************************************************************************************************************************
'Function Name: CEditMP_SearchRecentAddBtn()
'Function Desc : In 'View Editorial Historical states page  ' this function Searchs the REcent Add Button  and clicks on it to add more states 
'Return : Nil
'Example : CEditMP_SearchRecentAddBtn()
'Author: Supriya
'Created Date : 20/08/14
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************


Function CEditMP_SearchRecentAddBtn()
 	
On error Resume Next 
				
				
				'Get the count of the States visible 
				vContents = Browser("Datahub").Page("View historical metering").WebTable("State Details").GetCellData(1,1)
				vRegExpCount = RegExp_matchesCount(vContents)  
			 	vNumberofStates = vRegExpCount - 1
			 	
			 	'Set the html id for the delete button to be deleted
			 	Browser("Datahub").Page("View historical metering").WebElement("Add").SetTOProperty "html id",".*ctl0" & vNumberofStates & "_AddStateDHButton_DHButton"


	If Err.Number <> 0 Then
			CafeReporter "CEditMP_SearchRecentAddBtn","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If	

  End Function
'************************************************************************************************************************************************
'Function Name: CEditMP_AddMoreStates(vNumbOfStates)
'Parameter : vNumbOfStates - Number of States to be added 
'Function Desc : After creating one state if the user desires to add more states . This function adds the number of Historical STATES  as desired by the user. 
'Return : Nil
'Example : CEditMP_AddMoreStates()
'Author: Supriya
'Created Date : 20/08/14
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************

Function CEditMP_AddMoreStates(vNumbOfStates) 

On Error Resume Next 

'			Environment.Value("NumberOfStates") = vNumbOfStates + 1
			'SCREEN
			For Iterator = 1 To vNumbOfStates  Step 1 ' Iterates till the desired states are added
									Browser("Datahub").Page("View historical metering").WebElement("Add").SetTOProperty "html id",".*ctl0" & Iterator & "_AddStateDHButton_DHButton"
									Browser("Datahub").Page("View historical metering").WebElement("Add").Engine("#CLICK--2")
									
							  		vValidFromDateInput = CEditMP_SetValidFromDate() 'Gets the valid date input to set 
							 
									With Browser("Datahub").Page("Add historical metering")
												.Sync
												.Engine("#EXIST--Y")
												.WebEdit("ValidFromDateInput").Engine(vValidFromDateInput)																						
													SetValidFromDate															
											.WebElement("Submit").Click
									
									End With
									
		
			Next
			
			If Err.Number <> 0  Then
				CafeReporter "CEditMP_AddStates","Add More States","Pass","The Desired Number of States should be added.No of States added :- '" & vNumbOfStates & "'","Yes"
			Else
				CafeReporter "CEditMP_AddStates","Add More States","Pass","The Desired Number of States should be added","Nope"			
			End If
				
					
				
End Function


'************************************************************************************************************************************************
'Function Name: CEditMP_CompareStates( )
'Parameter : Nil
'Function Desc : Compares the two states in the 'History tab' and checks if the recent Date craeted has MP Type value as exepected    
'Return : Nil
'Example : CEditMP_CompareStates()
'Author: Supriya
'Created Date : 20/08/14
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function CEditMP_CompareStates()

On Error Resume Next 

	
			'SCREEN
			
			'1.0 Link History visible
			Browser("Datahub").Page("View metering point").Link("History").Engine("#CLICK--2")
			
		
			'2.0 COMPARE
			With Browser("Datahub").Page("View meteringpoint history")
					 .Engine("#EXIST--Y")
					 .WebRadioGroup("FirstCompareRadiobutton").Select "rdSelect1"
					 .WebRadioGroup("SecondCompareButton").Select  "rdSelect2"
					 .WebElement("Compare").Engine("#CLICK--2")
					 
					 
					 
		 	End With 
		 	
		 								 
							 
 	If Err.Number <> 0 Then
					CafeReporter "CEditMP_CompareStates","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
			End If	
End Function 
'************************************************************************************************************************************************
'Function Name: CEditMP_ViewCompareStatesRes( )
'Parameter : Nil
'Function Desc : Verifies the Result of Compared states in the 'History tab' and checks the Physical Status of MP is different    
'Return : Nil
'Example : CEditMP_ViewCompareStatesRes()
'Author: Supriya
'Created Date : 20/08/14
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	
Function CEditMP_ViewCompareStatesRes()
On Error Resume Next 	
  
		With Browser("Datahub").Page("View meteringpoint history").WbfGrid("CompareResults")		
			
			
				.ChkComparedStatesResults "Physical status of MP","DIFF"
				
		End WITh	
								
							 
							 
 	If Err.Number <> 0 Then
					CafeReporter "CEditMP_ViewCompareStatesRes","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
			End If		
 
End Function 


 


'************************************************************************************************************************************************
'Function Name: CDeleteMP_SearchRecentDeleteBtn()
'Function Desc : Search the Delete button with the most recent date  
'Return : Nil
'Example : CDeleteMP_SearchRecentDeleteBtn()
'Author: Supriya
'Created Date : 21/08/14
'Last Edited Date : 
'Modification History:
  
'************************************************************************************************************************************************




Function CDeleteMP_SearchRecentDeleteBtn()
 	
On error Resume Next 
				
				
				'Get the count of the States visible 
				vContents = Browser("Datahub").Page("View historical metering").WebTable("State Details").GetCellData(1,1)
				vRegExpCount = RegExp_matchesCount(vContents)  
			 	vNumberofStates = vRegExpCount - 1
			 	
			 	'Set the html id for the delete button to be deleted
			 	Browser("Datahub").Page("View historical metering").WebElement("Delete").SetTOProperty "html id",".*ctl0" & vNumberofStates & "_DeleteStateDHButton_Button"


	If Err.Number <> 0 Then
			CafeReporter "CDeleteMP_SearchRecentDeleteBtn","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If	

  End Function
  
  
  
'************************************************************************************************************************************************
'Function Name: RegExp_matchesCount()
'Function Desc : Count the number of items repeated in the content available  
'Return : Nil
'Example : RegExp_matchesCount("abc abc cde")
'Author: Supriya
'Created Date : 21/08/14
'Last Edited Date : 
'Modification History:
  
'************************************************************************************************************************************************


  Function RegExp_matchesCount(Contents)
  	
  On Error Resume Next 	
			 Set rgxp = New Regexp 
			 rgxp.Pattern = "State Details" 
			 rgxp.IgnoreCase = False 
			 rgxp.Global = True 
			 Set matches = rgxp.Execute( Contents ) 
			 RegExp_matchesCount = matches.Count
			 
			 
	If Err.Number <> 0 Then
			CafeReporter "RegExp_matchesCount","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If			 
			 
  End Function
  
  
 '************************************************************************************************************************************************
'Function Name: CDeleteMP_VerifyTransfer()
'Function Desc : Count the number of items repeated in the content available  
'Return : Nil
'Example : CDeleteMP_VerifyTransfer()
'Author: Supriya
'Created Date : 21/08/14
'Last Edited Date : 
'Modification History:
  
'************************************************************************************************************************************************

  
  Function CDeleteMP_VerifyTransfer()
  	
  	On Error Resume Next 
  	
  	
				'1.0 ''Success Message Verification for transfer draft 	
				
				vMsg = Browser("Datahub").Page("View historical metering").WebElement("SuccessMsgLabel").GetROProperty("innertext")			
				vSuccessMsg = GetXML("CREATE_SPLMP","SUCCESS_MSG")
				
				
				If Browser("Datahub").Page("View historical metering").WebElement("View historical metering").Exist(10) Then
					CafeReporter "CDeleteMP_VerifyTransfer","Edit historical Metering Point" ,"Pass","Transfer Draft is done succesfully.Success Message ::" &vMsg ,"Yes"
					Else			
					CafeReporter "CDeleteMP_VerifyTransfer","Edit historical Metering Point" ,"Fail","Transfer Draft is done succesfully","Nope"	
				End If
				
				
				
				'2.0  Check if  validate Draft, save Draft and Transfer Draft buttons  are disbaled  after clicking on Transfer Button 
				
				
				strDisableValidate =	Browser("Datahub").Page("View historical metering").WebElement("Validate draft").Object.disabled
				strDisableTransfer =	Browser("Datahub").Page("View historical metering").WebElement("Transfer draft").Object.disabled
				strDisableSave =	Browser("Datahub").Page("View historical metering").WebElement("Save draft").Object.disabled
				
				
				If strDisableValidate and  strDisableTransfer and strDisableSave Then
					CafeReporter "CDeleteMP_VerifyTransfer","Delete historical Metering Point" ,"Pass","'Transfer Draft,Save Draft and Validate Draft' buttons are grayed out","Yes"	
				Else
					CafeReporter "CDeleteMP_VerifyTransfer","Delete historical Metering Point" ,"Fail","'Transfer Draft,Save Draft and Validate Draft' buttons are grayed out","Nope"	
				End If
									
									
				
	If Err.Number <> 0 Then
			CafeReporter "CDeleteMP_VerifyTransfer","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If						
  End Function
 
 
 '************************************************************************************************************************************************
'Function Name: CEditMP_SaveValidSubmitDraft()
'Function Desc : Deletes Existing Historical States for the Historical Metring point 
'Return : Nil
'Example : CEditMP_SaveValidSubmitDraft()
'Author: Supriya
'Created Date :21/08/14
'Last Edited Date : 
'Modification History:

'***********************************************************************************************************************************************
Function CDeleteMP_SaveValidDraft()
		
 	
 	On Error Resume Next 	
 	
 								With Browser("Datahub").Page("View historical metering")
 								
 								
										.WebElement("Save draft").Engine("#waittime--10||#CLICK--2")										 
									
										vMsg = Browser("Datahub").Page("View historical metering").WebElement("SuccessMsgLabel").GetROProperty("innertext")	'Success Message Verification			
										vSuccessMsg = GetXML("CREATE_SPLMP","SUCCESS_MSG")
										If Browser("Datahub").Page("View historical metering").WebElement("SuccessMsgLabel").Exist(10) Then
											CafeReporter "CDeleteMP_SaveValidDraft","Edit historical Metering Point" ,"Pass","Save Draft is done succesfully.Success Message ::" &vMsg ,"Yes"
										Else			
											CafeReporter "CDeleteMP_SaveValidDraft","Edit historical Metering Point" ,"Fail","SaveS Draft is done succesfully","Nope"	
										End If
													 
								  
										
										.WebElement("Validate draft").Engine("#CLICK--2")
										 vMsg = Browser("Datahub").Page("View historical metering").WebElement("SuccessMsgLabel").GetROProperty("innertext")	'Success Message Verification			
										 vSuccessMsg = GetXML("CREATE_SPLMP","SUCCESS_MSG")
										 If Browser("Datahub").Page("View historical metering").WebElement("SuccessMsgLabel").Exist(10) Then
											CafeReporter "CDeleteMP_SaveValidDraft","Edit historical Metering Point" ,"Pass","Validate Draft is done succesfully.Success Message ::" &vMsg ,"Yes"
										 Else			
											CafeReporter "CDeleteMP_SaveValidDraft","Edit historical Metering Point" ,"Fail","Validate Draft is done succesfully","Nope"	
										 End If
								
							 End With
							
							
							
 	
	If Err.Number = 0  Then							
			CafeReporter "CDeleteMP_SaveValidDraft","Validated and Submitted  Draft successfully", "Pass","Draft should be Validated and Saved successfully ","Yes"
	Else						
			CafeReporter "CDeleteMP_SaveValidDraft","Validated and Submitted  Draft successfully", "Fail","Draft should be Validated and Saved successfully ","Nope"
    End If
				
 End Function 
 	
 
 
 '************************************************************************************************************************************************
'Function Name: CHistMP_ViewStateDetails()
'Function Desc : View the States Details of the Created Hist MP 
'Return : Nil
'Example : CHistMP_ViewStateDetails()
'Author: Supriya
'Created Date :21/08/14
'Last Edited Date : 
'Modification History:

'***********************************************************************************************************************************************

Function  CHistMP_ViewStateDetails(vExpNumbOfStates)
	
	On Error Resume Next 
	
				'1.0 . Get the Count of States Visible
				vContents = Browser("Datahub").Page("View historical metering").WebTable("State Details").GetCellData(1,1)
				vNumberofStates = RegExp_matchesCount(vContents) ' get teh count of sttes 
'			  	vNumberofStates = vRegExpCount - 1
			  	
			  	
			  	
			  	'2.0 Check if the States created are available
			  	If cint(trim(vNumberofStates)) = cint(trim(vExpNumbOfStates)) then'Environment.Value("NumberOfStates") Then 
			  				 
			  				CafeReporter "CHistMP_ViewStateDetails","View State Details" ,"Pass","Number of State available is as expected." ,"Yes.Count of states:-" & vNumberofStates
			  				PosValidFrom = Instr(vContents,"Valid from")
							PosValidTo  = Instr(vContents,"Valid to")
							PosPhys = Instr(vContents,"Physical details")
							  				
			  				CafeReporter "CHistMP_ViewStateDetails","View State Details. State:- 1"  ,"Pass","Valid From Date :-  " & Mid(vContents,PosValidFrom +Len("Valid from"),(PosPhys - PosValidTo- Len("Valid to")- 1))	 ,"Info"
					  		CafeReporter "CHistMP_ViewStateDetails","View State Details. State :- 1"  ,"Pass","Valid To Date :-  " & Mid(vContents,PosValidTo +Len("Valid to"),(PosPhys - PosValidTo- Len("Valid to")- 1)) ,"Info"
			  				
				Else
							CafeReporter "CHistMP_ViewStateDetails","View State Details" ,"Fail","Number of State available is as expected.","Nope. actual Count of states:-" &vNumberofStates				
			  	End If 
			  	
			  	
			  	
			  	'3.0 Get the  New State Details 
			  	
			  	  For Iterator = 1 To vNumberofStates - 1  Step 1
			  	  
			  	  		Browser("Datahub").Page("View historical metering").WebTable("NewState").SetTOProperty "innerhtml",".*ctl0"&Iterator&"_StateDetailsPanelBar.*"
		
					   vValidFromVal = Browser("Datahub").Page("View historical metering").WebTable("NewState").GetCellData (1,2)'Valid From Date value
					   vValidToVal = Browser("Datahub").Page("View historical metering").WebTable("NewState").GetCellData (2,2)'Valid To value   
					   CafeReporter "CHistMP_ViewStateDetails","View State Details. State:- " & Iterator + 1  ,"Pass","Valid From Date :-  " & vValidFromVal ,"Info"
					   CafeReporter "CHistMP_ViewStateDetails","View State Details. State :-" & Iterator + 1 ,"Pass","Valid To Date :-  " & vValidToVal ,"Info"
					   
				 Next
			 
 
			   
	If Err.Number <> 0 Then
			CafeReporter "CHistMP_ViewStateDetails","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If				   
			  	
			  	
			  															
End Function 

 '************************************************************************************************************************************************
'Function Name: CDeleteMP_VerifyDelete()
'Function Desc : Verify if teh State is deleted  
'Return : Nil
'Example : CDeleteMP_VerifyDelete()
'Author: Supriya
'Created Date :22/08/14
'Last Edited Date : 
'Modification History:

'***********************************************************************************************************************************************



Function CDeleteMP_VerifyDelete(vExpNumberofStates)
	
On Error Resume Next 	
				'1.0 Find the count of States visible 
				
				vContents = Browser("Datahub").Page("View historical metering").WebTable("State Details").GetCellData(1,1)
				vNumberofStates = RegExp_matchesCount(vContents) ' get teh count of sttes 
'			  	vNumberofStates = vRegExpCount - 1
			  	
			  	
			  	'2.0 check if the recent date is deleted 
			  	If cint(Trim(vNumberofStates)) = cint(trim(vExpNumberofStates)) then 'Environment.Value("NumberOfStates") - 1  Then
'			  				Environment.Value("NumberOfStates") = Environment.Value("NumberOfStates") - 1
			  	
			  				CafeReporter "CDeleteMP_VerifyDelete","Verify Deleted State Details" ,"Pass","State with recent date is Deleted " ,"Yes.Count of States :: " & vNumberofStates
				
			  	
						  	PosValidFrom = Instr(vContents,"Valid from")
							PosValidTo  = Instr(vContents,"Valid to")
							PosPhys = Instr(vContents,"Physical details")
							  				
			  				CafeReporter "CHistMP_ViewStateDetails","View State Details. State:- 1"  ,"Pass","Valid From Date :-  " & Mid(vContents,PosValidFrom +Len("Valid from"),(PosPhys - PosValidTo- Len("Valid to")- 1))	 ,"Info"
					  		CafeReporter "CHistMP_ViewStateDetails","View State Details. State :- 1"  ,"Pass","Valid To Date :-  " & Mid(vContents,PosValidTo +Len("Valid to"),(PosPhys - PosValidTo- Len("Valid to")- 1)) ,"Info"
			  				
				Else
							CafeReporter "CDeleteMP_VerifyDelete","Verify Deleted State Details" ,"Fail","State with recent date is Deleted " ,"Nope. ACTUAL Count of States :: " & vExpNumberofStates  
			  
			  	End If
			  	
			  	
			  	'3.0 Get the  New State Details 
			  	
			  	  For Iterator = 1 To vNumberofStates - 1  Step 1
			  	  
			  	  		Browser("Datahub").Page("View historical metering").WebTable("NewState").SetTOProperty "innerhtml",".*ctl0"&Iterator&"_StateDetailsPanelBar.*"
		
					   vValidFromVal = Browser("Datahub").Page("View historical metering").WebTable("NewState").GetCellData (1,2)'Valid From Date value
					   vValidToVal = Browser("Datahub").Page("View historical metering").WebTable("NewState").GetCellData (2,2)'Valid To value   
					   CafeReporter "CHistMP_ViewStateDetails","View State Details. State:- " & Iterator + 1  ,"Pass","Valid From Date :-  " & vValidFromVal ,"Info"
					   CafeReporter "CHistMP_ViewStateDetails","View State Details. State :-" & Iterator + 1 ,"Pass","Valid To Date :-  " & vValidToVal ,"Info"
					   
				 Next
			  	
			  	
	
	
	
	If Err.Number <> 0 Then
			CafeReporter "CDeleteMP_VerifyDelete","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If	
	
	
End Function
		
	 	
 '************************************************************************************************************************************************
'Function Name: CDeleteMP_SubmitDraft()
'Function Desc : with FAS user clicks on Submit Draft to  finally delete  the state 
'Return : Nil
'Example : CDeleteMP_SubmitDraft()
'Author: Supriya
'Created Date :22/08/14
'Last Edited Date : 
'Modification History:

'***********************************************************************************************************************************************

								

 	
 Function CDeleteMP_SubmitDraft()
 
 On Error Resume Next 
 							 
						 	
						 	'1.0 SCREEN
						 	With Browser("Datahub").Page("View metering point") 
						 			.WebElement("Edit historical states").Click
						 	End With 	
						  
						 	wait 5
						 	
							With Browser("Datahub").Page("View historical metering")
									.WebElement("Submit draft").Engine("#CLICK--5")
							End With 
							
							'2.0 SUCCESS Msg Verification 
						
								 
								vMsg = Browser("Datahub").Page("View metering point").WebElement("SuccessMsgLabel").GetROProperty("innertext")	
								
								vSuccessMsg = GetXML("CREATE_SPLMP","SUCCESS_MSG")
								If Browser("Datahub").Page("View metering point").WebElement("SuccessMsgLabel").Exist(20) Then
									CafeReporter "CDeleteMP_SubmitDraft","CDeleteMP_SubmitDraft" ,"Pass","Submit Draft is done succesfully.Success Message ::" &vMsg ,"Yes"
									Else			
									CafeReporter "CDeleteMP_SubmitDraft","CDeleteMP_SubmitDraft" ,"Fail","Submit Draft is done succesfully","Nope"	
									Exit Function
								End If
'								
								With Browser("Datahub").Page("View metering point") 
						 			.WebElement("Edit historical states").Engine("#CLICK--5")
						 		End With 	
						  
								

		

	If Err.Number <> 0 Then
		CafeReporter "CDeleteMP_SubmitDraft","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If 						

 
 End Function 

'************************************************************************************************************************************************
'Function Name: CUserRole_VerifyMsg()
'Function Desc   :Verifies the Success Message 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CUserRole_VerifyMsg()
'Author: Supriya
'Created Date :  27-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	


Function CUserRole_VerifyMsg() 

On Error Resume Next 
		'Success Message Verification
			vMsg = Browser("Datahub").Page("View user role").WebElement("SuccessMsgLabel").GetROProperty("innertext")				
			vSuccessMsg = GetXML("CREATE_SPLMP","SUCCESS_MSG")
			
			
			If Strcomp(Trim(vMsg),Trim(vSuccessMsg),1) = 0 Then
				CafeReporter "CUserRole_VerifyMsg","CUserRole_VerifyMsg" ,"Pass","Success Message is displayed successfully.Success Message is dipalyed as ::" &vMsg ,"Yes"
				Else			
				CafeReporter "CUserRole_VerifyMsg","CUserRole_VerifyMsge" ,"Fail","Success Message is displayed successfully","Nope"	
			End If
			
 If Err.Number <> 0 Then
		CafeReporter "CUserRole_VerifyMsg","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If 				
						
End Function
						
'************************************************************************************************************************************************
'Function Name: Fn_RandomNum()
'Function Desc   :Returns a Random Number 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : Fn_RandomNum()
'Author: Supriya
'Created Date :  27-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	

Function Fn_RandomNum()

On Error Resume Next	

		min = 1
 		max = 10000
 
		Randomize
		Fn_RandomNum = Cint((max-min+1)*Rnd + max)
		
		
		
If Err.Number <> 0 Then
		CafeReporter "Fn_RandomNum","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
End If 			
 
End Function
'************************************************************************************************************************************************
'Function Name: CUserRole_SelectSystemFunction()
'Function Desc   :Selects the System function Verifies the serach result
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CUserRole_SelectSystemFunction()
'Author: Supriya
'Created Date :  22-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	
Function CUserRole_SelectSystemFunction()

On error resume next 	

						'1.0 Get teh Default Organisation id value 
						
						strDefaultOrgId = Browser("Datahub").Page("Create user role").WebEdit("OrganisationId").getroproperty("default value")
						Environment.Value("OrganisationID") =strDefaultOrgId
						
						'2.0 Select  system Function
						
						rwcnt = Browser("Datahub").Page("Create user role").WbfGrid("SystemFunction").RowCount
											
						For Iterator = 2 To rwcnt Step 1
							
								strCellval = Browser("Datahub").Page("Create user role").WbfGrid("SystemFunction").GetCellData(Iterator,2)
								
								If not Instr(Ucase(strCellval),"UPDATE") > 0 and   not Instr(Ucase(strCellval),"CREATE") > 0   Then
								
									Browser("Datahub").Page("Create user role").WbfGrid("SystemFunction").SetCellData Iterator,1,"ON"
									wait 1
									
								End If
						Next
If Err.Number <> 0 Then
		CafeReporter "CUserRole_SelectSystemFunction","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
End If 	
End Function





'************************************************************************************************************************************************
'Function Name: SUserRole_VerifySearch()
'Function Desc   :Verifies the serach result
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SUserRole_VerifySearch()
'Author: Supriya
'Created Date :  22-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	
Function SUserRole_VerifySearch()
On Error REsume Next 


						
						 
						 vRoleName 			= Environment.Value("RoleNameSearch") 
						 vOrganisationID	= Environment.Value("OrganisationIDSearch") 
						 print  Environment.Value("OrganisationIDSearch")
						 
						'3.0 CODE 
							If  Browser("Datahub").Page("Search user roles").WbfGrid("ResultGrid").exist(10)  Then
							
										
									rwcntRes = Browser("Datahub").Page("Search user roles").WbfGrid("ResultGrid").RowCount
			                        
			                        If rwcntRes > 1 Then
			'                        	
								
	                        			strUserRole  	  =Browser("Datahub").Page("Search user roles").WbfGrid("ResultGrid").GetCellData(2,1)
				                        strOrganizationid  =Browser("Datahub").Page("Search user roles").WbfGrid("ResultGrid").GetCellData(2,2)
				                        
				                         
				                        
				                        If strcomp(Trim(strUserRole),vRoleName) = 0   Then
				                        	CafeReporter "SUserRole_VerifySearch","SUserRole_VerifySearch","Pass","User Rolename is as expecetd Rolename as :- " & vRoleName,"Yes"
				                       	Else
				                       	    CafeReporter "SUserRole_VerifySearch","SUserRole_VerifySearch","Fail","User Rolename is as expecetd Rolename as :- " & vRoleName,"Nope"
				                        	
				                        End If
				                        print err.number
				                         
				                       		 If vOrganisationID <> "" Then
				                        	
				                        
						                        If   Instr(Trim(strOrganizationid),vOrganisationID) > 0 Then
						                        	CafeReporter "SUserRole_VerifySearch","SUserRole_VerifySearch","Pass","UserRole OrganizationID is as expected with ID as :- " &vOrganisationID,"Yes"
						                       	Else
						                       	    CafeReporter "SUserRole_VerifySearch","SUserRole_VerifySearch","Fail","UserRole OrganizationID is as expected with ID as :- " &vOrganisationID,"Nope"
						                        End If 
			                        		End If
	                        		End If
	                        		
	                       Else
							 CafeReporter "SUserRole_VerifySearch","SUserRole_VerifySearch","Fail","UserRole OrganizationID is as expected ","Nope"	                       
                        
                      End If 

If Err.Number <> 0 Then
			CafeReporter "SUserRole_VerifySearch","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
		End If                    
	             
End Function



'************************************************************************************************************************************************
'Function Name: EUserRole_SelectSystemFunc()
'Function Desc   :Selects System Function    
'Arguments: Uses Cafe framework
'Return : Nil
'Example : EUserRole_SelectSystemFunc()
'Author: Supriya
'Created Date : 27-08-14 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	

Function EUserRole_SelectSystemFunc()
On ErroR rESUME nEXT 
	
						rwcnt = Browser("Datahub").Page("Edit user role").WbfGrid("SystemFunctions").rowcount
						If rwcnt > 0  Then									
										
											
							For Iterator = 2 To 5 Step 1
								'Only select CREATE Options 
									strCellval =Browser("Datahub").Page("Edit user role").WbfGrid("SystemFunctions").GetCellData(Iterator,2)
									With Browser("Datahub").Page("Edit user role")
										
									
											If  Instr(Ucase(strCellval),"CREATE") > 0   Then
											
												.WbfGrid("SystemFunctions").SetCellData Iterator,1,"ON"
												 
											Else	
												.WbfGrid("SystemFunctions").SetCellData Iterator,1,"OFF"
												 									
												
											End If
									End With
							Next
												
						End If 
						
						
	If Err.Number = 0  Then
		CafeReporter "EUserRole_SelectSystemFunc","EUserRole_SelectSystemFunc" ,"Pass","CREATE System Functions are selected" ,"Yes"
	Else	
		CafeReporter "EUserRole_SelectSystemFunc","EUserRole_SelectSystemFunc" ,"Fail","CREATE System Functions are selected" ,"Nope.Err.Number :-" & err.number & "and error description " &err. description
	End If					
End Function
'************************************************************************************************************************************************
'Function Name: CUserRole_DeleteRole()
'Function Desc   :Deletes User   and check if its   deleted 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CUserRole_DeleteRole()
'Author: Supriya
'Created Date :  
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	
Function CUserRole_DeleteRole()

On Error REsume Next 

							
'				
						 
						 '1.0 SCREEN		
						
 
							Browser("Datahub").Page("Search user roles").WbfGrid("ResultGrid").ClickCell 2,1
					 
							
							With Browser("Datahub").Page("View user role")  'PopUp Message Window 
									.WebElement("Delete").Engine("#CLICK--2")
									.Frame("Frame").Engine("#EXIST--Y")  
								 	.Frame("Frame").WebElement("Delete").Engine("#CLICK--5")
					
							End With 
							
							
					 
							
							
		 If Err.Number = 0 Then
		 
		 CafeReporter "CUserRole_DeleteRole","CUserRole_DeleteRole ", "Pass","User should be deleted","Yes"
		 Else
		 CafeReporter "CUserRole_DeleteRole","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""
												
		End If                    
					

							
End Function 

'************************************************************************************************************************************************
'Function Name: DUserRole_ValidateDelete()
'Function Desc   :Validates if user role  is   deleted 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : DUserRole_ValidateDelete()
'Author: Supriya
'Created Date :  
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	

Function DUserRole_ValidateDelete()
	
On Error Resume Next 	
						rwcntRes =Browser("Datahub").Page("Search user roles").WebTable("Role name").RowCount
			                    
			                    If rwcntRes > 1 Then
			                    	strCellVal =Browser("Datahub").Page("Search user roles").WebTable("Role name").GetCellData(2,1)
			                        
			                        If Instr(Ucase(strCellVal),"NO RECORDS") > 0   Then
			                        	CafeReporter "DUserRole_ValidateDelete","Search Deleted User Role Not in Use","Pass","No Records Found.UserRole not in use Deleted successfully" ,"Yes"
			                       	Else
			                       	    CafeReporter "DUserRole_ValidateDelete","Search Deleted User Role Not in Use","Fail","No Records Found.UserRole not in use Deleted successfully" ,"Nope"
			                        	
			                        End If
			                    
			
			                    End If
 If Err.Number <> 0 Then
		CafeReporter "DUserRole_ValidateDelete","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If                    
				
	
	
End Function


'************************************************************************************************************************************************
'Function Name: DUserRoleInUse_ValidateErr()
'Function Desc   :Deletes User in Use and check if its not deleted 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : DUserRoleInUse_ValidateErr()
'Author: Supriya
'Created Date :  
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************

Function DUserRoleInUse_ValidateErr()
On error Resume Next 

			
												
							'Error MESSAGE Verification
							 If Browser("Datahub").Page("View user role").WebElement("Error").Exist(2) then
								strErrorText = Browser("Datahub").Page("View user role").WebElement("Error").GetROProperty("innertext")
								CafeReporter "DUserRoleInUse_ValidateErr","Delete Role in Use","Pass","UserRole should not be  deleted as it is in use .The Error Message Found  is :-" & strErrorText ,"Yes"
																			
								
							End If

							Browser("Datahub").Page("View user role").WebElement("Cancel").Engine("#CLICK--2")	
If Err.Number <> 0 Then
		CafeReporter "DUserRoleInUse_ValidateErr","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If  
End Function



'************************************************************************************************************************************************
'Function Name: SUserRole_SearchCount()
'Function Desc   :Gives the count of teh Search result
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SUserRole_SearchCount()
'Author: Supriya
'Created Date : 31-08-2014 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************

'
Function SUserRole_SearchCount()
On Error resume next
		 				 
						 
						'1.0 SCREEN 
								If Browser("Datahub").Page("Search user roles").WbfGrid("ResultGrid").Exist(10) Then
										rwcntRes = Browser("Datahub").Page("Search user roles").WbfGrid("ResultGrid").RowCount
										If rwcntRes > 1  Then
											CafeReporter "SUserRole_SearchCount","SUserRole_SearchCount","Pass","Number of Search results found :: "   & rwcntRes,"Yes"
										Else
											CafeReporter "SUserRole_SearchCount","SUserRole_SearchCount","Fail"," Search results found","Nope"										
										End If
								Else
										CafeReporter "SUserRole_SearchCount","SUserRole_SearchCount","Fail","No Search results found","Nope.No results found"								
					                        
								End If 


If Err.Number <> 0 Then
		CafeReporter "SUserRole_SearchCount","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
End If    				 
			
	
End Function

'************************************************************************************************************************************************
'Function Name: SUserRole_VerifyClickCell()
'Function Desc   :Verifies the  result of first cell that is being clicked on the search result page 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SUserRole_VerifyClickCell()
'Author: Supriya
'Created Date : 31-08-2014 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************

Function SUserRole_VerifyClickCell()

	On Error Resume Next 	
					
					rwcntRes = Browser("Datahub").Page("Search user roles").WbfGrid("ResultGrid").RowCount
					If rwcntRes > 1  Then
							Browser("Datahub").Page("Search user roles").WbfGrid("ResultGrid").ClickCell 2,1
							With Browser("Datahub").Page("View user role")
								.Engine("#EXIST--Y")
								.WebElement("Cancel").Engine("#CLICK--2||@SUserRole_SearchCount()")
							End with
					
					End If
					
If Err.Number <> 0 Then
		CafeReporter "SUserRole_VerifyClickCell","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
End If  		
	
End Function					
						
						
                        
                        
 

						
'************************************************************************************************************************************************
'Function Name: CUser_VerifySuccMsg()
'Function Desc   :Verifies Success Message displayed 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CUser_VerifySuccMsg()
'Author: Supriya
'Created Date : 27-08-14 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
	
Function CUser_VerifySuccMsg()
	
				
	On Error Resume Next 	
					'Success Message Verification
					vMsg = Browser("Datahub").Page("View user").WebElement("SuccessMsgLabel").GetROProperty("innertext")	
 					
					vSuccessMsg = GetXML("CREATE_SPLMP","SUCCESS_MSG")
					
					If Strcomp(Trim(vMsg),Trim(vSuccessMsg),1) = 0  Then
						CafeReporter "CUser_VerifySuccMsg","CUser_VerifySuccMsg" ,"Pass"," Success Message displayed ::" &vMsg ,"Yes"
						Else		
						CafeReporter "CUser_VerifySuccMsg","CUser_VerifySuccMsg" ,"Fail","Success Message displayed","Nope"	
						Exit Function
					End If
					
	If Err.Number <> 0 Then
		CafeReporter "CUser_VerifySuccMsg","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If    				 
						
						
End Function	
 
'************************************************************************************************************************************************
'Function Name: CPortalUser_SelectRoles()
'Function Desc   :selects UserRoles  for creating user 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CPortalUser_SelectRoles()
'Author: Supriya
'Created Date : 27-08-14 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function CPortalUser_SelectRoles()
	On Error Resume Next 
	
	
			 vRole =GetXML( "CREATE_USER","ROLE")
			
					'GET Organisation Id value 
					 Environment.Value("OrganisationID") =Browser("Datahub").Page("Create user").WebEdit("OrganisationId").GetROProperty("default value")
			Select Case Ucase(vRole)
			
			Case "ADMIN"
				'Select Specific USer  Roles 
					 bFound = False 
					 rwcnt = Browser("Datahub").Page("Create user").WbfGrid("SelectRoles").RowCount
						
					 	
						For Iterator = 2 To rwcnt Step 1
							
								strCellval = Browser("Datahub").Page("Create user").WbfGrid("SelectRoles").GetCellData(Iterator,2)
								print  strCellval
								 
								If Instr(Ucase(strCellval),"SYSTEMADMIN") > 0    Then
									bFound = True 
								
									Browser("Datahub").Page("Create user").WbfGrid("SelectRoles").SetCellData Iterator,1,"ON"	
																	
									
								End If
						Next
						
						If bFound Then
							CafeReporter "CUser_SelectRoles","CUser_SelectRoles ","Pass","  Admin Role Selected","Yes"	
						Else
							CafeReporter "CUser_SelectRoles","CUser_SelectRoles ","Fail","Admin Role Selected","Nope.Could not find the item "							
						End If
			
				
			 		 
			Case Else 
					'Select Specific USer  Roles 
					 bFound = False 
					 rwcnt = Browser("Datahub").Page("Create user").WbfGrid("SelectRoles").RowCount
						
					 	
						For Iterator = 2 To rwcnt Step 1
							
								strCellval = Browser("Datahub").Page("Create user").WbfGrid("SelectRoles").GetCellData(Iterator,2)
								 
								If Instr(Ucase(strCellval),"MARKETPORTAL DDM") > 0 or  Instr(Ucase(strCellval),"DATAHUB DDM") > 0   Then
									bFound = True 
								
									Browser("Datahub").Page("Create user").WbfGrid("SelectRoles").SetCellData Iterator,1,"ON"	
																	
									
								End If
						Next
						
						If bFound Then
							CafeReporter "CUser_SelectRoles","CUser_SelectRoles ","Pass","Selecting  MARKETPORTAL DDM and DATAHUB DDM","Yes"	
						Else
							CafeReporter "CUser_SelectRoles","CUser_SelectRoles ","Fail","Selecting  MARKETPORTAL DDM and DATAHUB DDM","Nope.Could not find the item "							
						End If
								
						

		End Select


		
If Err.Number <> 0 Then
		CafeReporter "CUser_SelectRoles","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If  						
End Function




'************************************************************************************************************************************************
'Function Name: CSystemUser_SelectRoles()
'Function Desc   :selects UserRoles  for creating user 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CSystemUser_SelectRoles()
'Author: Supriya
'Created Date : 27-08-14 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function CSystemUser_SelectRoles()
On Error Resume Next 

				rwcnt = Browser("Datahub").Page("Create user").WbfGrid("SelectRoles").RowCount
						
					 
						For Iterator = 2 To rwcnt Step 1
							
								strCellval = Browser("Datahub").Page("Create user").WbfGrid("SelectRoles").GetCellData(Iterator,2)
								
								
								If   Instr( strCellval,"B2B DH MarketMessaging DDM") > 0   Then
								 
								
									Browser("Datahub").Page("Create user").WbfGrid("SelectRoles").SetCellData Iterator,1,"ON"
									CafeReporter "CSystemUser_SelectRoles","Create Market System user","Pass","Selecetd 'B2B DH MarketMessaging DDM' User Role" ,"Yes"									
									Exit for	
									
								End If
						Next
						
		If Err.Number <>0 Then
		 
		  
		 CafeReporter "CSystemUser_SelectRoles","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""
												
		End If                    
					

End Function 




'************************************************************************************************************************************************
'Function Name: SUser_SearchCount()
'Function Desc   :Gives the count of teh Search result
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SUser_SearchCount()
'Author: Supriya
'Created Date : 31-08-2014 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function SUser_SearchCount()
On Error resume next
		 				vOrganisationID 	=  Environment.Value("OrganisationIDSearch")
						 vUserName 			= Environment.Value("MarketUserNameSearch")	
						 
						 
						'3.0 SCREEN 
								If Browser("Datahub").Page("Search users").WbfGrid("ResultGrid").Exist(10) Then
										rwcntRes = Browser("Datahub").Page("Search users").WbfGrid("ResultGrid").RowCount
										If rwcntRes > 1  Then
											CafeReporter "SUser_SearchCount","SUser_SearchCount","Pass","Number of Search results found :: "   & rwcntRes,"Yes"
										Else
											CafeReporter "SUser_SearchCount","SUser_SearchCount","Fail"," Search results found","Nope"										
										End If
								Else
										CafeReporter "SUser_SearchCount","SUser_SearchCount","Fail","No Search results found","Nope.No results found"								
					                        
								End If 


If Err.Number <> 0 Then
		CafeReporter "SUser_SearchCount","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
End If    				 
			
	
End Function


'************************************************************************************************************************************************
'Function Name: SUser_VerifyWildCard()
'Function Desc   :Verifies search of wild card characters search 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SUser_VerifyWildCard()
'Author: Supriya
'Created Date : 31-08-2014 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function SUser_VerifyWildCard()

	On ERROR resume next	
					
					rwcntRes = Browser("Datahub").Page("Search users").WbfGrid("ResultGrid").RowCount
					If rwcntRes > 1  Then
							Browser("Datahub").Page("Search users").WbfGrid("ResultGrid").ClickCell 2,1
							With Browser("Datahub").Page("View user")
								.Engine("#EXIST--Y")
								.WebElement("Cancel").Engine("#CLICK--2||@SUser_SearchCount()")
							End with
					
					End If
	If Err.Number <> 0 Then
		CafeReporter "SUser_VerifyWildCard","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
End If  
End Function
'************************************************************************************************************************************************
'Function Name: CUser_ValidateSearch()
'Function Desc   :Validates  Serach resyult of User Searched 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CUser_ValidateSearch()
'Author: Supriya
'Created Date :  
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************

Function CUser_ValidateSearch()


	On Error Resume next 
	
						
						 
							
						 vOrganisationID 	=  Environment.Value("OrganisationIDSearch")
						 vUserName 			= Environment.Value("MarketUserNameSearch")	
						 
						 
						'3.0 SCREEN 
								If Browser("Datahub").Page("Search users").WbfGrid("ResultGrid").Exist(10) Then
								
							
											rwcntRes = Browser("Datahub").Page("Search users").WbfGrid("ResultGrid").RowCount
					                        
					                       	 If rwcntRes > 1 Then
							                        	strUserName	  =Browser("Datahub").Page("Search users").WbfGrid("ResultGrid").GetCellData(2,1)
							                      		strOrganizationid  = Trim(Browser("Datahub").Page("Search users").WbfGrid("ResultGrid").GetCellData(2,4))
							                        
							                     			                         
									                        
									                        If strcomp(Lcase(Trim(strUserName)),Lcase(vUserName)) = 0   Then
									                        	CafeReporter "CUser_ValidateSearch","Search Results for Market Portal User  ","Pass","User Rolename is as expecetd Username as :- " & vUserName,"Yes"
									                       	Else
									                       	    CafeReporter "CUser_ValidateSearch","Search Results for Market Portal User  ","Fail","User Rolename is as expecetd Username as :- " & vUserName,"Nope"
									                        	
									                        End If
									                   
															
														If not strOrganizationid = "" Then 
															
																											
									                        
									                        If  Instr(vOrganisationID,strOrganizationid) >0 Then
									                        	CafeReporter "CUser_ValidateSearch","CUser_ValidateSearch","Pass","User  OrganizationID is as expected with ID as :- " &strOrganizationid,"Yes"
									                       	Else
									                       	    CafeReporter "CUser_ValidateSearch","CUser_ValidateSearch","Fail","User  OrganizationID is as expected with ID as :- " &strOrganizationid,"Nope"
									                        End If 
									                   End If		     
									                        
				                       		 End If
				                 End If  
				                        
	
	If Err.Number <> 0 Then
		CafeReporter "CUser_ValidateSearch","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If    				 
				
	
End Function

	






'************************************************************************************************************************************************
'Function Name: ChangePswrd_VerifyMsg()
'Function Desc : Verifies Message for  Changed Password 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : ChangePswrd_VerifyMsg()
'Author: Supriya
'Created Date :  
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************

Function ChangePswrd_VerifyMsg()
	
	On Error Resume Next

		strExpMsgChgPswrd = Environment.value("ExpMsgChgPswrd")
		Select Case strExpMsgChgPswrd
		
			Case "SUCCESSMSG"
				'Message Verification of Changed Password
					 wait 5 
						Browser("Datahub").Page("Datahub").WebEdit("Languages").Engine("#SELECT--English") 
						 
						
					If Browser("Datahub").Page("Datahub").WebElement("SuccessMsg").Exist(10) Then 
					 	vMsg = Browser("Datahub").Page("Datahub").WebElement("SuccessMsg").GetROProperty("innertext")	
		   			 	CafeReporter "ChangePswrd_VerifyMsg","Change Password Message","Pass","Changed Password Message dispalyed successfully::" &vMsg,"Yes"
		   			 	
		   			 Else
		   			 	CafeReporter "ChangePswrd_VerifyMsg","Change Password Message","Fail","Change Password Message displayed successfully","Nope "	   			 
		  
		     		End If 	
			
			
			Case "ERRMSG"					     		
		
							'Error Messgae If Any 
						If Browser("Datahub").Page("Datahub").WebElement("ErrMsgPassword").Exist(30) then
							vMsg = Browser("Datahub").Page("Datahub").WebElement("ErrMsgPassword").GetROProperty("innertext")	
			   			 	CafeReporter "ChangePswrd_VerifyMsg","Change Password Message","Pass","Error Message for Password Change displayed  ::" &vMsg,"Yes"
			   			 	
			   			Else
							 
			   			 	CafeReporter "ChangePswrd_VerifyMsg","Change Password Message","Fail","Error Message for Password Change displayed ","Nope"					   			
		
						End If 
		
		End Select 
		
		If Err.Number <> 0 Then
		CafeReporter "ChangePswrd_VerifyMsg","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If 	
End Function



'************************************************************************************************************************************************
'Function Name: COrg_VerifySuccMsg()
'Function Desc   :Checks ifCreate Organisation is successful 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : COrg_VerifySuccMsg()
'Author: Supriya
'Created Date : 31-08-2014 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************

Function COrg_VerifySuccMsg()
	On Error Resume Next 
	vMsg = Browser("Datahub").Page("View organisation").WebElement("SuccessMsg").GetROProperty("innertext")				
	vSuccessMsg = GetXML("CREATE_SPLMP","SUCCESS_MSG")
									If Strcomp(trim(vMsg),trim(vSuccessMsg),1) = 0 Then
										CafeReporter "COrg_VerifySuccMsg"," Create Organisation" ,"Pass","  Success Message is displayed ::" &vMsg ,"Yes"
										Else			
										CafeReporter "COrg_VerifySuccMsg","Create Organisation" ,"Fail","Success message is displayed ","Nope"	
									End If
	 If Err.Number <> 0 Then
					CafeReporter "COrg_VerifySuccMsg","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If                    



End Function 



'************************************************************************************************************************************************
'Function Name: SOrg_SearchCount()
'Function Desc   :Gives the count of teh Search result
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SOrg_SearchCount()
'Author: Supriya
'Created Date : 31-08-2014 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function SOrg_SearchCount()
On Error resume next
		 				
						'3.0 SCREEN 
								If Browser("Datahub").Page("Search organisations").WbfGrid("ResultGrid").Exist(10) Then
										rwcntRes = Browser("Datahub").Page("Search organisations").WbfGrid("ResultGrid").RowCount
										If rwcntRes > 1  Then
											CafeReporter "SOrg_SearchCount","SOrg_SearchCount","Pass","Number of Search results found :: "   & rwcntRes,"Yes"
										Else
											CafeReporter "SOrg_SearchCount","SOrg_SearchCount","Fail"," Search results found","Nope"										
										End If
								Else
										CafeReporter "SOrg_SearchCount","SOrg_SearchCount","Fail","No Search results found","Nope.No results found"								
					                        
								End If 


If Err.Number <> 0 Then
		CafeReporter "SOrg_SearchCount","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
End If    				 
			
	
End Function


'************************************************************************************************************************************************
'Function Name: SOrg_VerifyClickCell()
'Function Desc   :Verifies search of wild card characters search 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SOrg_VerifyClickCell()
'Author: Supriya
'Created Date : 31-08-2014 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function SOrg_VerifyClickCell()

	On error resume next 	
					
					rwcntRes = Browser("Datahub").Page("Search organisations").WbfGrid("ResultGrid").RowCount
					If rwcntRes > 1  Then
							Browser("Datahub").Page("Search organisations").WbfGrid("ResultGrid").ClickCell 2,1
							With Browser("Datahub").Page("View organisation")
								.Engine("#EXIST--Y")
								.WebElement("Cancel").Engine("#CLICK--2||@SOrg_SearchCount()")
							End with
					
					End If
					
	If Err.Number <> 0 Then
		CafeReporter "SOrg_VerifyClickCell","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
End If				
	
End Function

'************************************************************************************************************************************************
'Function Name: COrg_VerifYSearchResult()
'Function Desc   :Verifies the Search result for the Organisation Serached 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : COrg_VerifYSearchResult()
'Author: Supriya
'Created Date : 31-08-2014 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************

Function COrg_VerifYSearchResult()

On Error REsume Next 


				vOrganisationID	 	= Environment.Value("OrganisationIDSearch")
				vOrganisationName	= Environment.Value("OrganisationNameSearch")			
		

						
			rwcntRes = Browser("Datahub").Page("Search organisations").WbfGrid("ResultGrid").RowCount
                        
                        If rwcntRes > 1 Then
                        	strOrganisationName 	  =Browser("Datahub").Page("Search organisations").WbfGrid("ResultGrid").GetCellData(2,2)
	                        strOrganizationid  			=Browser("Datahub").Page("Search organisations").WbfGrid("ResultGrid").GetCellData(2,1)
	                        
	                        
	                        
	                        If strcomp(Trim(lcase(vOrganisationName)),lcase(strOrganisationName),1) = 0  Then
	                        	CafeReporter "COrg_VerifYSearchResult","Search Results for Organisation","Pass","Organisation found successfully  as expected with OrganisationName as :- " & strOrganisationName ,"Yes"
	                       	Else
	                       	    CafeReporter "COrg_VerifYSearchResult","Search Results for Organisation","Fail","Organisation   found successfully as expected   with OrganisationName as :- " & strOrganisationName  ,"Nope "
	                        	
	                        End If
	                        
	                        If vOrganisationID <> "" Then
	                        	
	                        
			                        If Instr(Trim(lcase(strOrganizationid)),lcase(vOrganisationID)) > 0  Then
			                        	CafeReporter "COrg_VerifYSearchResult","Search Results for Organisation","Pass","Organisation found successfully  as expected with OrganisationID as :- " & vOrganisationID ,"Yes"
			                       	Else
			                       	    CafeReporter "COrg_VerifYSearchResult","Search Results for Organisation","Fail","Organisation   found successfully as expected   with OrganisationID as :- " & vOrganisationID  ,"Nope "
			                        	
			                        End If
                       		 End If
	                        	
                       	Else
                       		 CafeReporter "COrg_VerifYSearchResult","Search Results for Organisation","Fail","Organisation not found  with OrganisationName as expected" ,"Nope.No records found "
						End If 	
	
 


	 If Err.Number <> 0 Then
		CafeReporter "COrg_verifYSearchResult"," Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If  

End Function 
 '************************************************************************************************************************************************
'Function Name: EOrg_VerifyActiveOrgStatus()
'Function Desc   :Verifies the Organisation created is active 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : EOrg_VerifyActiveOrgStatus()
'Author: Supriya
'Created Date : 31-08-2014 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function EOrg_VerifyActiveOrgStatus()
On error Resume next 

					'Check status for active 		
							 strStatus = Browser("Datahub").Page("Search organisations").WbfGrid("ResultGrid").GetCellData(2,5)
							 
							 If strStatus = "Active" Then
							 	CafeReporter "EOrg_VerifyActiveOrgStatus","Activate Organisation ","Pass","Organisation Status is Active"," Yes"
'							  
							 Else
							 
							 End If
							
							 If Err.Number <> 0 Then
								CafeReporter "EOrg_VerifyActiveOrgStatus","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
							End If  

 If Err.Number <> 0 Then
		CafeReporter "EOrg_VerifyActiveOrgStatus","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If   
                   
End Function 


 
 '************************************************************************************************************************************************
'Function Name: COrg_DeleteOrganisation()
'Function Desc   :Deletes  Organisation
'Arguments: Uses Cafe framework
'Return : Nil
'Example : COrg_DeleteOrganisation()
'Author: Supriya
'Created Date :  
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************		
Function COrg_DeleteOrganisation()
	
	On Error Resume Next 

	
'	

'						'1.0 SCREEN	
						Browser("Datahub").Page("Search organisations").WbfGrid("ResultGrid").ClickCell 2,1

						Browser("Datahub").Page("View organisation").WebElement("Delete").Click
						
						
						
						'PopUp Message Window
'				

				with Browser("Datahub").Page("View organisation")
					.Frame("Frame").Engine("#EXIST--Y")  
					.Frame("Frame").WebElement("Delete").engine("#CLICK--2") 'Press Delete  Button in the Delete Pop up message 
						
				End with
						 
'	 
					 
	

				 If Err.Number <> 0 Then
					CafeReporter "COrg_DeleteOrganisation","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
				End If     
	
	
	
	
End Function

 '************************************************************************************************************************************************
'Function Name: CheckDeleteOrganisation()
'Function Desc   :Verify if   Organisation is deleted 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CheckDeleteOrganisation()
'Author: Supriya
'Created Date :  
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	


Function CDeleteOrg_VerifyDelete()	
	
	On Error Resume Next 
				rwcntRes = Browser("Datahub").Page("Search organisations").WebTable("Organisation ID").RowCount                  


  
	
                        If rwcntRes > 1 Then
                        	strCellVal  	  =Browser("Datahub").Page("Search organisations").WebTable("Organisation ID").GetCellData(2,1)
	                        
	                        If Instr(Ucase(strCellVal),"NO RECORDS") > 0   Then
	                        	CafeReporter "CDeleteOrg_VerifyDelete","Delete Organistaion","Pass","Organisation Deleted successfully.NO RECORDS FOUND  ","Yes"
	                       	Else
	                       	    CafeReporter "CDeleteOrg_VerifyDelete","Delete Organisation","Fail","Organisation  Deleted successfully" ,"Nope"
	                        	
	                        End If
	                        
	                     Else
	                     	  CafeReporter "CDeleteOrg_VerifyDelete","Delete Organisation","Fail","Organisation  Deleted successfully" ,"Nope.Records Found"
				                     
						End If 
						
						
		 If Err.Number <> 0 Then
					CafeReporter "CheckDeleteOrganisation","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
		 End If     
					
End Function	








'************************************************************************************************************************************************
'Function Name: CContact_VerifySearch()
'Function Desc   : Verifies Search result 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CContact_VerifySearch()
'Author: Supriya
'Created Date :  
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************

Function CContact_VerifySearch()

On Error resume Next 	

vContactName = Environment.value("ContactNameSearch")
vOrganisationCode = Environment.value("OrganisationCodeSearch")

								If Browser("Datahub").Page("Search contacts").WbfGrid("ResultGrid").Exist(10) Then 
									
															
										rwcntRes = Browser("Datahub").Page("Search contacts").WbfGrid("ResultGrid").RowCount
							                        
							                        If rwcntRes > 1 Then
							                        	strContactName 	  =Browser("Datahub").Page("Search contacts").WbfGrid("ResultGrid").GetCellData(2,1)
								                        strOrganisationCode  =Browser("Datahub").Page("Search contacts").WbfGrid("ResultGrid").GetCellData(2,2)
								                       
								                        If Instr(Trim(lcase(vContactName)),lcase(strContactName)) > 0   Then
								                        	CafeReporter "CContact_VerifySearch","Search Results for Contact","Pass","Contact found successfully with ContactName as :- " & strContactName ,"Yes"
								                       	Else
								                       	    CafeReporter "CContact_VerifySearch","Search Results for Contact","Fail","Contact   found  with ContactName as :- " & strContactName ,"Nope "
								                        	
								                        End If
								                        
								                        
								                        If   Instr(vOrganisationCode,TRim(strOrganisationCode) ) > 0  Then
								                        	CafeReporter "CContact_VerifySearch","Search Results for Contact","Pass","Contact found successfully with  OrganizationCode :-" &strOrganisationCode,"Yes"
								                       	Else
								                       	    CafeReporter "CContact_VerifySearch","Search Results for Contact","Fail","Contact   found  with  OrganizationCode :-" &strOrganisationCode,"Nope  "
								                        	
								                        End If
							                        
							                        End If 	
	                       	Else
	                       		 CafeReporter "CContact_VerifySearch","Search Results for Contact","Info","Contact   found  with ContactName as :- " & strContactName & " and OrganizationCode :-" &strOrganisationCode,"Nope "
							End If 

	
	If Err.Number <> 0 Then
			CafeReporter "CContact_VerifySearch","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If   
		
	 						

End Function

'************************************************************************************************************************************************
'Function Name: CContact_VerifySuccMsg()
'Function Desc   : Verifies Succes Msg  
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CContact_VerifySuccMsg()
'Author: Supriya
'Created Date :  
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	
Function CContact_VerifySuccMsg()
On Error Resume next
vMsg = Browser("Datahub").Page("View contact").WebElement("SuccessMsg").GetROProperty("innertext")
 
 If Browser("Datahub").Page("View contact").WebElement("SuccessMsg").Exist(2) Then 
	
	CafeReporter "CContact_VerifySuccMsg","CContact_VerifySuccMsg ","Pass","Success Message is displayed successfully"  & vMsg,"Yes "
Else
	CafeReporter "CContact_VerifySuccMsg","CContact_VerifySuccMsg","Fail","Success Message is displayed successfully","Nope"	   			 
	
End If 

	If Err.Number <> 0 Then
		CafeReporter "CContact_VerifySuccMsg","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If   
			

End Function





'************************************************************************************************************************************************
'Function Name: CContact_DeleteContact()
'Function Desc   : Deletes Contact 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CContact_DeleteContact()
'Author: Supriya
'Created Date :  
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************		
	Function CContact_DeleteContact()
	
	
		On Error Resume Next
		
		
'						'1.0 SCREEN	
						Browser("Datahub").Page("Search contacts").WbfGrid("ResultGrid").ClickCell 2,1

						Browser("Datahub").Page("View contact").WebElement("Delete").Click
						
						
						
						 
'				

						With  Browser("Datahub").Page("View contact").Frame("Frame")
								.Engine("#EXIST--Y")
								.WebElement("Delete").Engine("#CLICK--2")'Press Delete  Button in the Delete Pop up message
						End With 
 


	
	
		 If Err.Number <> 0 Then
			CafeReporter "CContact_DeleteContact","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
		 End If  
	
	



	End Function
'************************************************************************************************************************************************
'Function Name: DContact_VerifyDelete()
'Function Desc   : Verify Deleted    Contact 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : DContact_VerifyDelete()
'Author: Supriya
'Created Date :  
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************		
Function DContact_VerifyDelete()
		rwcntRes = Browser("Datahub").Page("Search contacts").WebTable("Contact name").RowCount			
						                 

                        If rwcntRes > 1 Then
                        	strCellVal =Browser("Datahub").Page("Search contacts").WebTable("Contact name").GetCellData(2,1)
	                        
	                        If Instr(Ucase(strCellVal),"NO RECORDS") > 0   Then
	                        	CafeReporter "DContact_VerifyDelete","Delete contacts","Pass","Contact Deleted successfully with ContactName as :- " & vContactName,"Yes"
	                       	Else
	                       	    CafeReporter "DContact_VerifyDelete","Delete contacts","Fail","Contact not deleted  with ContactName as :- " & vContactName ,"Nope "
	                        	
	                        End If
			End If 
 If Err.Number <> 0 Then
			CafeReporter "DContact_VerifyDelete","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
End If  
	

End Function
'************************************************************************************************************************************************
'Function Name: CResp_GetGridArea()
'Function Desc   :To use Grid area code for Creates responisbility   
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CResp_GetGridArea()
'Author: Supriya
'Created Date :  07-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	


Function CResp_GetGridArea()
	
				On Error Resume Next
				
	vOption  = Environment.Value("Save_Resp")			
				
	Select Case IsNull(vOption )
	
	Case TRUE 
		
									CResp_GetGridArea =  "Haren (986)"
	 			
	Case Else
				
									
									
									'Access tables within DB_CAFE.accdb													
									
									If oRds.State = 1 Then	'Close Recordset if opened earlier.
											oRds.Close
									End If

									Sql_GetGAC = "Select GRID_AREACODE from GridAreaCode where USED <>'Yes' ORDER BY Id"
																					
									'OPENING THE RECORSET FROM THE Driver TABLE													
									oRds.Open Trim(Sql_GetGAC), oCnn,2,3
																		
									If oRds.EOF <> True Then		'Recordset NotEqual to Null
									
											oRds.MoveFirst	'Move the index to first
											
										 Environment.Value("GAC") = Trim(oRds.Fields("GRID_AREACODE").Value) 'Set MP as Environment variable
											
										print 	Environment.Value("GAC")
											SQL_Update_GAC = "Update GridAreaCode Set USED ='Yes' where GRID_AREACODE ='" & Trim(Environment.Value("GAC")) & "'"
											
											oRds.Close	'Close the existing recordset
											
											oRds.Open Trim(SQL_Update_GAC), oCnn,2,3	'update table
																						
											Else
											Reporter.ReportEvent micWarning, "Query Function","Recordset is empty, check SQL string or DB for more details."
											
									End If	
									print err.number
									CResp_GetGridArea =  Environment.Value("GAC")	
									print err.number

		
	End Select  
															
																	
	If Err.Number <> 0 Then
				CafeReporter "CResp_GetGridArea","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	 End If 			
	
	
End Function

'************************************************************************************************************************************************
'Function Name: CResp_VerifySuccMsg()
'Function Desc   :Verifies the Success Message after creating the Responsibility 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CResp_VerifySuccMsg()
'Author: Supriya
'Created Date : 31-08-2014 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************

Function CResp_VerifySuccMsg()
On error Resume Next 
	 
								
								
								 If Browser("Datahub").Page("View balance responsibility").WebElement("SuccessMsg").Exist(2) Then 
								 vMsg = Browser("Datahub").Page("View balance responsibility").WebElement("SuccessMsg").GetROProperty("innertext")	
								 		
									 	CafeReporter "CResp_VerifySuccMsg","CResp_VerifySuccMsg ","Pass","Success Message is displayed :: " &vMsg ,"Yes "
								Else
									 	CafeReporter "CResp_VerifySuccMsg","CResp_VerifySuccMsgy ","Fail","Success Message is displayed ","Nope"	   			 
								End If
If Err.Number <> 0 Then
				CafeReporter "CResp_VerifySuccMsg","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	 End If								
	 		 	            
End Function

'************************************************************************************************************************************************
'Function Name: SResp_ValidateCancel()
'Function Desc   :Vaælidates when User clicks Cancel button on View Responsibility    Page 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SResp_ValidateCancel()
'Author: Supriya
'Created Date :  28-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	

Function SResp_ValidateCancel()
	
 
On Error resume Next 
                  Browser("Datahub").Page("Search balance responsibilities").WbfGrid("ResultGrid").ClickCell 2,1 
										
										With Browser("Datahub").Page("View balance responsibility")
												.Engine("#EXIST--Y")
												.WebElement("Cancel").Engine("#EXIST--Y")
									 	End with 
								 
	If Err.Number <> 0 Then
				CafeReporter "SResp_ValidateCancel","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	 End If 
End Function

'************************************************************************************************************************************************
'Function Name: CResp_ValidateSearch()
'Function Desc   :Validates the Search result  
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CResp_ValidateSearch()
'Author: Supriya
'Created Date :  28-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	

Function CResp_ValidateSearch()

On error resume next 
	
					vBalanceResponsibleParty = Environment.Value("BalanceResponsiblePartySearch")	
					vTypeofMP				= Environment.Value("TypeofMPSearch")	
					vGridAreacode 			= 	Environment.Value("GridAreacodeSearch")	
					vSupplier 			 	= 	Environment.Value("SupplierSearch")			
 
		                        
		                      If Browser("Datahub").Page("Search balance responsibilities").WbfGrid("ResultGrid").Exist(10) Then 									
																
										rwcntRes = Browser("Datahub").Page("Search balance responsibilities").WbfGrid("ResultGrid").RowCount
										Environment.Value("NoOfResults") = rwcntRes
										
								        CafeReporter "CResp_ValidateSearch","Search Results for Responsibilty ","Pass"," Total '" & rwcntRes &  "' Results found for the Search ", "Yes"             
								        If rwcntRes > 1 Then
					                         	
																			                        
					                        	         
														 strSupplier  =Browser("Datahub").Page("Search balance responsibilities").WbfGrid("ResultGrid").GetCellData(2,1)
														 strBalanceResponsibleParty  =Browser("Datahub").Page("Search balance responsibilities").WbfGrid("ResultGrid").GetCellData(2,2)	
														 strGridArea  =Browser("Datahub").Page("Search balance responsibilities").WbfGrid("ResultGrid").GetCellData(2,3)	
														 strTypeofMP =Browser("Datahub").Page("Search balance responsibilities").WbfGrid("ResultGrid").GetCellData(2,4)	 
						                       
						                   		 If vSupplier <> "" Then                   		 	
						                   		 	
						                   								                   		                       
								                        If   Instr(vSupplier,strSupplier ) > 0  Then
								                        	CafeReporter "CResp_ValidateSearch","Search Results for Responsibilty","Pass"," Supplier value  is as expected","Yes"
								                       	Else
								                       	    CafeReporter "CResp_ValidateSearch","Search Results for Responsibilty","Fail"," Supplier value  is as expected","Nope  "
								                        	
								                        End If
						                        
						                        
						                        End If
						                        
						                         If vBalanceResponsibleParty <> "" Then 
						                                                
									                        If   Instr(vBalanceResponsibleParty,strBalanceResponsibleParty ) > 0  Then
									                        	CafeReporter "CResp_ValidateSearch","Search Results for Responsibilty ","Pass"," BalanceResponsibleParty value  is as expected","Yes"
									                       	Else
									                       	    CafeReporter "CResp_ValidateSearch","Search Results for Responsibilty","Fail"," BalanceResponsibleParty value  is as expected","Nope  "
									                        	
									                        End If
									                        
						                           End If 
												If vGridArea <> "" Then 								                           
								                        If   Instr(vGridArea ,strGridArea  ) > 0  Then
								                        	CafeReporter "CResp_ValidateSearch","Search Results for Responsibilty","Pass"," GridArea  value  is as expected","Yes"
								                       	Else
								                       	    CafeReporter "CResp_ValidateSearch","Search Results for Responsibilty","Fail"," GridArea  value  is as expected","Nope  "
								                        	
								                        End If
								                  End If 
												If vTypeofMP<> "" Then
													
												
									                                                
									                        If   Instr(vTypeofMP,strTypeofMP ) > 0  Then
									                        	CafeReporter "CResp_ValidateSearch","Search Results for Responsibilty ","Pass"," TypeofMP value  is as expected","Yes"
									                       	Else
									                       	    CafeReporter "CResp_ValidateSearch","Search Results for Responsibilty ","Fail"," TypeofMP value  is as expected","Nope  "
									                        	
									                        End If
						                        
						                        End If
						                        
						      
						                        
						                     	   
								          End If 
								
								 Else
								 	 	CafeReporter "CResp_ValidateSearch","Search Results for Responsibilty  ","Info"," Created Responisbilty not found .No records exist","Yes"
						                       
								End If 
	If Err.Number <> 0 Then
				CafeReporter "CResp_ValidateSearch","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	 End If 							 
	
End Function
'************************************************************************************************************************************************
'Function Name: SResp_ValidatePageCombo()
'Function Desc   :Validates the Pagesize combo box 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SResp_ValidatePageCombo()
'Author: Supriya
'Created Date :  28-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	

Function SResp_ValidatePageCombo()
	
	With  Browser("Datahub").Page("Search balance responsibilities")
			.WebElement("Search").Click 
	
'		                      

      If Browser("Datahub").Page("Search balance responsibilities").WbfGrid("ResultGrid").Exist(10) Then 									
										
				rwcntRes1 = Browser("Datahub").Page("Search balance responsibilities").WbfGrid("ResultGrid").RowCount
				
		        CafeReporter "SResp_ValidatePageCombo","Search Results for Responsibilty ","Pass"," Made the Page Size to show 50 results.Total '" & rwcntRes1 &  "' Results found for the Search ", "Yes"             
		        
		     Else
				CafeReporter "SResp_ValidatePageCombo","Search Results for Responsibilty ","Pass"," Made the Page Size to show 50 results . Results found for the Search ", "Nope"             		     
	End If  
'							

 		.WebElement("Clear").Engine("#CLICK--2")	

									
				rwcntRes2 = Browser("Datahub").Page("Search balance responsibilities").WbfGrid("ResultGrid").RowCount
				
				If rwcntRes2 = Environment.Value("NoOfResults") Then
					
			
		        CafeReporter "SResp_ValidatePageCombo","Search Results for Responsibilty ","Pass"," Total '" & rwcntRes2 &  "' Results dispalyed after clicking on 'Clear All' button which is same as earlier results  ", "Yes"             
		        Else
		        
		        CafeReporter "SResp_ValidatePageCombo","Search Results for Responsibilty ","Fail"," Total '" & rwcntRes2 &  "' Results dispalyed after clicking on 'Clear All' button which is same as earlier results  ", "Nope"
		        
		        End If

End With 

If Err.Number <> 0 Then
		CafeReporter "SResp_ValidatePageCombo","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
End If 	

End Function

'************************************************************************************************************************************************
'Function Name: CUser_DeleteUser()
'Function Desc   :Deletes Market User 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CUser_DeleteUser()
'Author: Supriya
'Created Date :  08-08-2014
'Last Edited Date : 
'Modification History:
 '19-09-2014- Modified the name from SCR_DeleteUser
'************************************************************************************************************************************************	

Function CUser_DeleteUser()
On Error Resume Next 	
	
	
						 '1.0 SCREEN		
						
  
							Browser("Datahub").Page("Search users").WbfGrid("ResultGrid").ClickCell 2,1
							Browser("Datahub").Page("View user").WebElement("Delete").Engine("#CLICK--2")
							
							 
'				

							With  Browser("Datahub").Page("View user")
									.Frame("Frame").Engine("#EXIST--Y")
								 	.Frame("Frame").WebElement("Delete").Engine("#CLICK--2||#waittime--20")
			
								
							End With 

	
	
If Err.Number <> 0 Then
		CafeReporter "CUser_DeleteUser","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
End If 	
	
	
	
End Function

'************************************************************************************************************************************************
'Function Name: DUser_ValidateDelete()
'Function Desc   :Validates Deleted Market User 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : DUser_ValidateDelete()
'Author: Supriya
'Created Date :  08-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	



Function DUser_ValidateDelete()
	On Error resume Next
	
						rwcntRes =Browser("Datahub").Page("Search users").WebTable("Username").RowCount
			                    
			                    If rwcntRes > 1 Then
			                    	strCellVal  	  =Browser("Datahub").Page("Search users").WebTable("Username").GetCellData(2,1)
			                        
			                        If Instr(Ucase(strCellVal),"NO RECORDS") > 0   Then
			                        	CafeReporter "DUser_ValidateDelete","DUser_ValidateDelete ","Pass","No Records Found.User Deleted successfully" ,"Yes"
			                       	Else
			                       	    CafeReporter "DUser_ValidateDelete","DUser_ValidateDelete  ","Fail","No Records Found.User Deleted successfully" ,"Nope"
			                        	
			                        End If
			                    
			                    	
			                   
			
			                    End If
	
	If Err.Number <> 0 Then
		CafeReporter "DUser_ValidateDelete","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
End If 	
	
	
End Function


'************************************************************************************************************************************************
'Function Name: SendWebForm_ValidateSummary()
'Function Desc   :Validates the Summary page of Send WebForm 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SendWebForm_ValidateSummary()
'Author: Supriya
'Created Date :  08-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function SendWebForm_ValidateSummary()

	On error Resume Next 
	
	
						'1.0 VALIDATE Checkbox 'Add direct contact details
							
							If UCASE(Browser("Datahub").Page("Inquiry Summary").WebCheckBox("Checkbox").getroproperty("value"))  = "ON"  Then 
							 	CafeReporter "SendWebForm_ValidateSummary","Summary Page ","Pass","Checkbox 'Add direct contact details' is selected ","Yes"
							 Else
							 	CafeReporter "SendWebForm_ValidateSummary","Summary Page ","Fail","Checkbox 'Add direct contact details' is selected ","Nope"
							 End If 
							'
							 If not Browser("Datahub").Page("Inquiry Summary").WebElement("Add direct contact details").object.disabled   Then 
							 	CafeReporter "SendWebForm_ValidateSummary","Summary Page ","Pass","Checkbox 'Add direct contact details' is disabled and so the checkbox cannot be unselected ","Yes"
							 Else
							 	CafeReporter "SendWebForm_ValidateSummary","Summary Page ","Fail","Checkbox 'Add direct contact details' is disabled and so the checkbox cannot be unselected ","Nope"
							 End If 
						 
					 
					 
					 
						 '2.0 VALIDATE Supplier Contacts 
					 
						 	 rwcnt = Browser("Datahub").Page("Inquiry Summary").WebTable("Question").RowCount
							 If rwcnt > 5 Then
							 	CafeReporter "SendWebForm_ValidateSummary","Summary Page ","Pass"," Supplier Contact is diplayed  ","Yes"
							 	For Iterator = 6 To rwcnt Step 1					 		
								 	 ColVal =Browser("Datahub").Page("Inquiry Summary").WebTable("Question").GetCellData(Iterator,2)
									 CellVal = Browser("Datahub").Page("Inquiry Summary").WebTable("Question").GetCellData(Iterator,3)
								 	 CafeReporter "SendWebForm_ValidateSummary","Summary Page Contact Details ","Pass","Supplier Contact  Details:: '" & ColVal  & "'  value is :- '" & CellVal &"'","Yes"
							 	 Next
									 
								 
							Else
								 	CafeReporter "SendWebForm_ValidateSummary","Summary Page ","Fail","Supplier Contact is diplayed ","Nope"
								
							End If
							
							
		 
						'3.0 VALIDATE Summary Table 
		 					If Browser("Datahub").Page("Inquiry Summary").WebTable("Summary").exist(10)  Then
							 	CafeReporter "SendWebForm_ValidateSummary","Summary Page ","Pass"," Summary Table is diplayed  ","Yes"
							 	rwcnt = Browser("Datahub").Page("Inquiry Summary").WebTable("Summary").RowCount
								 If rwcnt > 1 Then
								 	For Iterator = 1 To 2 Step 1					 		
									 	 ColVal = Browser("Datahub").Page("Inquiry Summary").WebTable("Summary").GetCellData(Iterator,1)
										 CellVal = Browser("Datahub").Page("Inquiry Summary").WebTable("Summary").GetCellData(Iterator,2)
									 	 CafeReporter "SendWebForm_ValidateSummary","Summary Table Details in Summary Page ","Pass","Summary Table Details  :: '" & ColVal  & "'  value is :- '" & CellVal &"'","yES"
								 	 Next
								 	 
								 End If
							 
							 Else
							 	CafeReporter "SendWebForm_ValidateSummary","Summary Page","Fail","Summary Table is diplayed ","Nope"
							
							 End If
							 
							 
							 
						 
	If Err.Number <> 0 Then
		CafeReporter "SendWebForm_ValidateSummary","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If 

End Function
Function  SendWebFrm_UploadFile()


On error Resume Next 
			vFile = GETXML("SEND_WEBFORM","FILE")
		
						With Browser("Datahub")
								 	 .Dialog("Choose File to Upload").WinEdit("File name").Engine(vFile)
								   	 wait 15
				 					.Dialog("Choose File to Upload").WinButton("Open").Engine("#Click--15")
				 					.Page("Inquiry Question").WebElement("Upload").Engine("#CLICK--2")
									  				
				 					
				 		End With 
			 		 
								
								
						'Verify if uploaded successfully 
						If Browser("Datahub").Page("Inquiry Question").WebElement("File uploaded successfully").Exist(2) Then
							vMsg = Browser("Datahub").Page("Inquiry Question").WebElement("File uploaded successfully").GetROProperty("innertext")
							CafeReporter "SendWebFrm_UploadFile","Upload Successful Message ","Pass","'Upload Successful Message :-  " & vMsg  & "'is displayed","Yes" 
							
						Else									
							CafeReporter "SendWebFrm_UploadFile","Upload Successful Message ","Fail","'Upload Successful Message :-  " & vMsg  & "'is displayed","Nope" 
						End If
						
						
						
						
	If Err.Number <> 0 Then
		CafeReporter "SendWebFrm_UploadFile","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If 			
					
End Function



'************************************************************************************************************************************************
'Function Name: SWebForm_ReceiveInquiries()
'Function Desc   :Check Received Enuireis of WebForm 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SWebForm_ReceiveInquiries()
'Author: Supriya
'Created Date :  
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************

Function  SWebForm_ReceiveInquiries()
On Error resume next
 

				 
				'1.0 Data for   Verification
				 Table     						 			= GetXML("VIEW_WEBFORM","TABLE") 'Environment.Value("ScriptID")
				 vScriptID								    = GetXML("VIEW_WEBFORM","SCRIPT_ID")  'Environment.Value("ScriptID")
				 vStep     						 			= GetXML("VIEW_WEBFORM","STEP") 'Environment.Value("ScriptID")
				 
				 
				 
				'1.1 QUERY
				 StrSQL = "Select * from " & Trim(Table) & " where Script_ID = '"& Trim(vScriptID) & "' and Step = '" & Trim(vStep) &"'"
			 
				
				'2.0 DATADICTIONARY		
				 GetRecord(StrSQL)
				
					vSubject						= GetRecord_Dict.Item(Ucase("Subject"))
					vQuestion						= GetRecord_Dict.Item(Ucase("Question"))
			 

				'3.0 FUNCTION CALL 
				NavigateTo("SendWebFormReceivedInquiries")
				
				'4.0 SCREEN
				With Browser("Datahub").Page("Received inquiries")
					.Engine("#EXIST--Y")
					.WebTable("Metering point ID").Engine("EXIST--Y||#waittime--10")
						
						rwcnt = Browser("Datahub").Page("Received inquiries").WebTable("Metering point ID").rowcount
						If rwcnt > 1 Then
							CafeReporter "SWebForm_ReceiveInquiries","Received Inquiries","Pass","List of Inquiries are shown.","Yes"
							
							
							'VALIDATE SUBJECT IS AS EXPECTEED 
							
							strSubject = Browser("Datahub").Page("Received inquiries").WebTable("Metering point ID").GetCellData(3,2)
			
							If Instr(Trim(vSubject) ,Trim(strSubject)) >  0 Then
								CafeReporter "SWebForm_ReceiveInquiries","Received Inquiries","Pass","'SUBJECT ' value is as expected.","Yes"
							Else
								CafeReporter "SWebForm_ReceiveInquiries","Received Inquiries","Fail","SUBJECT' value is as expected.","Nope"			
							End If
							
							
							
							'VALIDTAE QUESION IS AS EXPECTED 
							
							.WebTable("Metering point ID").ChildItem(3,4,"Link",0).click  'Click on View and Answer 
							.Frame("Frame").WebEdit("Message Body").Engine("#EXIST--Y")
							 
							strMsg =Browser("Datahub").Page("Received inquiries").Frame("Frame").WebEdit("Message Body").Getroproperty("default value")
							If Instr(strMsg,vQuestion) > 0   Then
								CafeReporter "SWebForm_ReceiveInquiries","Received Inquiries","Pass","'QUESTION MESSAGE ' value is displayed  as expected." &vQuestion,"Yes"
							Else
								CafeReporter "SWebForm_ReceiveInquiries","Received Inquiries","Fail","QUESTION MESsAGE ' value is displayed as expected.","Nope"
								
							End If
							
							
							
							'VALIDATE DOWNLOAD ATTACHMENT
							
							If Browser("Datahub").Page("Received inquiries").Frame("Frame").Link("Download attachment").Exisy(10)Then
								
								CafeReporter "SWebForm_ReceiveInquiries","Received Inquiries","Nope","Download Attachement is  available ","Yes"	
							 	
							 	 .Frame("Frame").Link("Download attachment").engine("#CLICK--2")
							 	 'Check Download attachment 
							
									If  Browser("Datahub").WinObject("Notification bar").Exist(3) Then
										CafeReporter "SWebForm_ReceiveInquiries","Received Inquiries","Pass","Attachment can be downloaded as expected.","Yes"
									Else
										CafeReporter "SWebForm_ReceiveInquiries","Received Inquiries","Fail","Attachment can be downloaded as expected.","Nope"					
									End If 
										
							Else
								CafeReporter "SWebForm_ReceiveInquiries","Received Inquiries","Fail","Download Attachement is   available ","Nope"		
							
							End If
							
					Else
						CafeReporter "SWebForm_ReceiveInquiries","Received Inquiries","Fail","List of Inquiries are shown.","Nope"					
						
					End If 	
				
					End With 

	If Err.Number <> 0 Then
		CafeReporter "SWebForm_ReceiveInquiries","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If 	
End Function


'************************************************************************************************************************************************
'Function Name: AWebForm_SentInquiries()
'Function Desc   :Answers a Inquiry sent 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : AWebForm_SentInquiries()
'Author: Supriya
'Created Date :  
'Last Edited Date : 
'Modification History:
 

Function AWebForm_SentInquiries()

				'1.0 Data for   Verification
				 Table     						 			= GetXML("VIEW_WEBFORM","TABLE") 'Environment.Value("ScriptID")
				 vScriptID								    = GetXML("VIEW_WEBFORM","SCRIPT_ID")  'Environment.Value("ScriptID")
				 vStep     						 			= GetXML("VIEW_WEBFORM","STEP") 'Environment.Value("ScriptID")
				 
				 
				 
				'1.1 QUERY
				 StrSQL = "Select * from " & Trim(Table) & " where Script_ID = '"& Trim(vScriptID) & "' and Step = '" & Trim(vStep) &"'"
				
				
				'2.0 DATADICTIONARY		
				 GetRecord(StrSQL)
				
				 vSubject							= GetRecord_Dict.Item(Ucase("Subject"))
				 vResponseMessage					= Environment.value("Response")
				 
				'3.0 Function Call 
				 NavigateTo("SendWebFormSentInquiries")
				
				'4.0 SCREEN
 
				With Browser("Datahub").Page("Sent inquiries")
					.Engine("#EXIST--Y")
					.WebTable("From (username)").Engine("EXIST--Y")
					
					rwcnt = Browser("Datahub").Page("Sent inquiries").WebTable("From (username)").rowcount
					If rwcnt > 1 Then
					
					
							'VALIDATE SUBJECT IS AS EXPECETED 
									CafeReporter "AWebForm_SentInquiries","Received Inquiries","Pass","List of Inquiries are shown.","Yes"
									strSubject = Browser("Datahub").Page("From (username) inquiries").WebTable("From (username)").GetCellData(3,2)
				'			 
									If strcomp(strSubject ,vSubject) = 0 Then
										CafeReporter "AWebForm_SentInquiries","Sent Inquiries","Pass","'SUBJECT' value is as expected.","Yes"
									Else
										CafeReporter "AWebForm_SentInquiries","Sent Inquiries","Fail","SUBJECT ' value is as expected.","Nope"			
									End If
			
							'CLICK ON  VIEW AND ANSWER
							
								.WebTable("From (username)").ChildItem(3,4,"Link",0).click  'Click on View and Answer 											
								.Frame("Frame").WebEdit("View Message").Engine("#EXIST--Y")
								
							 'VALIDATE ORIGINAL MESSAGE
							 
								strMsg =Browser("Datahub").Page("Received inquiries").Frame("Frame").WebEdit("Message Body").Getroproperty("default value")
								If Instr(strMsg,vResponseMessage) > 0   Then
									CafeReporter "AWebForm_SentInquiries","Sent Inquiries","Pass","'Message' value is displayed  as expected." &vResponseMessage,"Yes"
								Else
									CafeReporter "AWebForm_SentInquiries","Sent Inquiries","Fail","Message' value is displayed as expected.","Nope"
									
								End If
			 
				Else
					CafeReporter "AWebForm_SentInquiries","Sent Inquiries","Fail","List of Inquiries are shown.","Nope"		
					
					
				End If
		
		

	End With 

	If Err.Number <> 0 Then
		CafeReporter "AWebForm_SentInquiries","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If 	
	
	
End Function


'************************************************************************************************************************************************
'Function Name: MeterData_VerifyMsg()
'Function Desc   :Verifies the Success Message  
'Arguments: Uses Cafe framework
'Return : Nil
'Example : MeterData_VerifyMsg()
'Author: Supriya
'Created Date :  03-09-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	


Function MeterData_VerifyMsg() 

On Error Resume Next 
		'Success Message Verification
			vMsg = Browser("Datahub").Page("Meter data reading").WebElement("SuccessMsgLabel").GetROProperty("innertext")				
			vSuccessMsg = GetXML("CREATE_SPLMP","SUCCESS_MSG")
			
			
			If Strcomp(Trim(vMsg),Trim(vSuccessMsg),1) = 0 Then
				CafeReporter "MeterData_VerifyMsg","MeterData_VerifyMsg" ,"Pass","Success Message is displayed successfully.Success Message is dipalyed as ::" &vMsg ,"Yes"
				Else			
				CafeReporter "MeterData_VerifyMsg","MeterData_VerifyMsg" ,"Fail","Success Message is displayed successfully","Nope"	
			End If
			
 If Err.Number <> 0 Then
		CafeReporter "MeterData_VerifyMsg","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If 				
						
End Function
	

'************************************************************************************************************************************************
'Function Name: SubmitMPTime_VerifyMsg()
'Function Desc   :Verifies  Success   Message 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SubmitMPTime_VerifyMsg()
'Author: Supriya
'Created Date :  03-09-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	



Function SubmitMPTime_VerifyMsg() 

On Error Resume Next 
		'Success Message Verification
			vMsg = Browser("Datahub").Page("Meter data time series").WebElement("SuccessMsgLabel").GetROProperty("innertext")				
			vSuccessMsg = GetXML("CREATE_SPLMP","SUCCESS_MSG")
			
			
			If Strcomp(Trim(vMsg),Trim(vSuccessMsg),1) = 0 Then
				CafeReporter "SubmitMPTime_VerifyMsg","SubmitMPTime_VerifyMsg" ,"Pass","Success Message is displayed successfully.Success Message is dipalyed as ::" &vMsg ,"Yes"
				Else			
				CafeReporter "SubmitMPTime_VerifyMsg","SubmitMPTime_VerifyMsg" ,"Fail","Success Message is displayed successfully","Nope"	
			End If
			
 If Err.Number <> 0 Then
		CafeReporter "SubmitMPTime_VerifyMsg","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If 				
						
End Function

'************************************************************************************************************************************************
'Function Name: SubmitMPTime_GetMeasuredDate(vResolution)
'Function Desc   :Get Measured date forSubmitting MP 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SubmitMPTime_GetMeasuredDate("MONTH")
'Author: Supriya
'Created Date :  03-09-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	

Function SubmitMPTime_GetMeasuredDate(vResolution)
	On Error Resume Next 
	

		  
		 Select Case Ucase(vResolution)
		 	
		 	 
		 	
		 	Case "#SELECT--MONTH"
		 	
				x = WorkingDay(0)
				y = Split(Replace(DateAdd("m",1,x),"-","/"),"/")
		 		SubmitMPTime_GetMeasuredDate =  "01" &"/" &  y(1) & "/"  & y(2)
		 		
		 	Case Else 	
		 		sDate = WorkingDay(0) + 1
		 		SubmitMPTime_GetMeasuredDate = Replace(sDate,"-","/")
		 End Select
	


End Function

'************************************************************************************************************************************************
'Function Name: SubmitMPTime_SetEnergyQuantity(vResolution,vValue)
'Function Desc   :Submit MP Time Series  Sets the Energy Quantity when the Meter Reading occurrence is  ' Monthly'  
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SubmitMPTime_SetEnergyQuantityMonth("Hour","2")
'Author: Supriya
'Created Date :  03-09-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	
	Function SubmitMPTime_SetEnergyQuantity(vResolution,vValue)
	
	On Error Resume Next 
		
		 Select Case Ucase(vResolution)
		 	
		 	Case "HOUR"
		 	
				 vSum = 0 					 
	 
				Rwcnt = Browser("Datahub").Page("Meter data time series").WbfGrid("Result").RowCount
 	 
				 If Rwcnt > 1  Then
				 	For Iterator = 2 To rwcnt -1   Step 1
				 		 Browser("Datahub").Page("Meter data time series").WbfGrid("Result").SetCellData Iterator,2,vValue
				 		vSum =   vSum + vValue
				 	Next
				 	
				 	
				 End If
	 
	 		  'Get the sum value 
				Environment.value("SumValue") =  vSum
				ASum = Browser("Datahub").Page("Meter data time series").WbfGrid("Result").GetCellData(Rwcnt,2)
				
				
		 	
		 	Case "15 MINUTES"
		 	
		 	

				vSum = 0
			 						 
			 
				Rwcnt = Browser("Datahub").Page("Meter data time series").WbfGrid("ResultGrid15M").RowCount
			
				For Iterator = 2 To Rwcnt - 1 Step 1
					 
						Browser("Datahub").Page("Meter data time series").WbfGrid("ResultGrid15M").SetCellData Iterator,2,vValue
						Browser("Datahub").Page("Meter data time series").WbfGrid("ResultGrid15M").SetCellData Iterator,2,vValue,2
						Browser("Datahub").Page("Meter data time series").WbfGrid("ResultGrid15M").SetCellData Iterator,2,vValue,3
						Browser("Datahub").Page("Meter data time series").WbfGrid("ResultGrid15M").SetCellData Iterator,2,vValue,4
						vSum = vSum +vValue
						
				Next
				
				'Get the sum value 
				Environment.value("SumValue") =  vSum * 4 ' For getting all the 96 values rows for minute 	
		 	
		 	Case "MONTH"

			 					 
			 	Browser("Datahub").Page("Meter data time series").WebEdit("EnergyQuantity").Engine(vValue)
		
				 
			 	'Get the sum value 
				Environment.value("SumValue") =  vValue
		 		
		 	Case Else 	
		 End Select
		
		
	End Function
	
	
	

'************************************************************************************************************************************************
'Function Name: SubmitMPTime_ViewMeteringData()
'Function Desc   :View Time Series in Metering data tab
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SubmitMPTime_ViewMeteringData()
'Author: Supriya
'Created Date :  03-09-2014
'Last Edited Date : 
'Modification History:
 
'***********************************************************************************************************************************************
Function SubmitMPTime_ViewMeteringData(vDisplayResolution)
On Error Resume Next

						'1.0	DATA		
						Table     = GetXML("VIEW_MP","TABLE") 'Environment.Value("ScriptID")
						vScriptID = GetXML("VIEW_MP","SCRIPT_ID")  'Environment.Value("ScriptID")
						vStep     = GetXML("VIEW_MP","STEP") 'Environment.Value("ScriptID")
						 

				
						'1.1 QUERY
						 StrSQL = "Select * from " & Trim(Table) & " where Script_ID = '"& Trim(vScriptID) & "' and Step = '" & Trim(vStep) &"'"
						
						
						'2.0 DATADICTIONARY		
						 GetRecord(StrSQL)
						 
						 vUnit	 					= GetRecord_Dict.Item(Ucase("EnergyTimeSeriesMeasureUnit"))  
						 vDisplayResolution 		= "#SELECT--" & vDisplayResolution  'GETXML("SUBMITMP_TIME","RESOLUTION")
						 vStartDate					= GETXML("SUBMITMP_TIME","PERIODFROM_DATE") 
						 
						 
						 
						 'SCREEN
							Browser("Datahub").Page("View metering point").Link("Metering data").Click
						
							With  Browser("Datahub").Page("View metering data")
									.Sync
						 			.Link("Metered data").Engine("#EXIST--Y||#CLICK--2")
									.WebEdit("StartDate").Engine(vStartDate)
									.WebEdit("Unit").Engine(vUnit)
						 			.WebEdit("DisplayResolution").Engine(vDisplayResolution)
						 			.WebElement("Search").Engine("#CLICK--2")
'						 										 	 
						 			
						 			
						
						 	End With 	
If Err.Number <> 0 Then
		CafeReporter "SubmitMPTime_ViewMeteringData","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If 	
	
	
End Function
'************************************************************************************************************************************************
'Function Name: SubmitMeterReading_ViewMeteringData()
'Function Desc   :View the Meteering data that is submittedof a Meteer Reading 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SubmitMeterReading_ViewMeteringData( )
'Author: Supriya
'Created Date :  23-10-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************

Function SubmitMeterReading_ViewMeteringData()
	
	On Error Resume Next 
	
	vStartDate = WorkingDay(0)
	vEndDate = workingDay(0) + 31 
	
							'SCREEN
							Browser("Datahub").Page("View metering point").Link("Metering data").Click
						
							With  Browser("Datahub").Page("View metering data")
									.Sync
						 			.Link("Metered readings").Engine("#EXIST--Y||#CLICK--2")
									.WebEdit("StartDate").Engine(vStartDate)
									.WebEdit("EndDate").Engine(vEndDate)
									.WebElement("Search").Engine("#CLICK--2")
						 		
									
							End With

	If Err.Number <> 0 Then
		CafeReporter "SubmitMeterReading_ViewMeteringData","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If 
End Function
'************************************************************************************************************************************************
'Function Name: SubmitMP_ChangeResolutionHr()
'Function Desc   :Change the Resolution to Hour 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SubmitMP_ChangeResolutionHr( )
'Author: Supriya
'Created Date :  23-10-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function SubmitMP_ChangeResolutionHr()

On Error resume next 
							
							'CODE
							SETXML  "SUBMITMP_TIME","VALUE","4"
							
							With  Browser("Datahub").Page("View metering data")
									
						 			.WebEdit("DisplayResolution").Engine("#SELECT--HOUR")
						 			.WebElement("Search").Engine("#CLICK--2")
						 			
'						 						
						 	End With 
						 	

If Err.Number <> 0 Then
		CafeReporter "SubmitMP_ChangeResolutionHr","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If
End Function


 
'************************************************************************************************************************************************
'Function Name: SubmitMPTime_VerifyMeterData(Byval Val,Byval Quan_Qual,Byval Exp_Resolutio)
'Function Desc   :Verify Time Seriues in Metering data tab
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SubmitMPTime_VerifyMeterData("2","MEASURED","HOUR")
'Author: Supriya
'Created Date :  23-10-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function SubmitMPTime_VerifyMeterData(Byval Val,Byval Quan_Qual,Byval Exp_Resolution)

	On Error Resume Next 
	 	 
					Err_Cmp = False 'Flag for Error

	 	 			Dt = GETXML("SUBMITMP_TIME","PERIODFROM_DATE") ''GetDt_XML("ISCALC::EFF_DT_SPLMP")		'Get the Period Date
					Dt_chgFormat = Split(dt,"/")
					Dt_YYYYMMDD = Trim(Dt_chgFormat(2)) &"-"& Trim(Dt_chgFormat(1)) &"-"& Trim(Dt_chgFormat(0))		'converting the date format from DD/MM/YYYY to YYYY-MM-DD
 
	 	 
					Hour_Array = Split(GetXML("ISCALC","Hour_Reading"),",")
					Minute_Array = Split(GetXML("ISCALC","Minute_Reading"),",")
					Month_Array = Array("2014-"& Month(GETXML( "SUBMITMP_TIME","PERIODFROM_DATE")) )
					
					Select Case Ucase(Exp_Resolution)
						
					Case "HOUR"
						ArrayCheck = Hour_Array
						Exp_rwcnt 	= 24
						Exp_date = Dt_YYYYMMDD 
'						
					Case 	"15 MINUTES"

						ArrayCheck = Minute_Array
						Exp_rwcnt 	= 96
						Exp_date = Dt_YYYYMMDD
						
					Case Else
						ArrayCheck = Month_Array 
						Exp_rwcnt 	= 1
						Exp_date = ""
					
											
					End Select
					
					
					
	
					With Browser("Datahub").Page("View metering data").WebTable("Period")
					
								.Exist(15) 'Sync								
								rcount = .RowCount		'This method adds the row of header and table border to the count by default. So the actual row count of record is "rcount -2"
								
								
								If rcount-2 <> Ubound(ArrayCheck)+ 1 Then		'Validate whether the row counts reflect 24  hours enteries  or 96 minute	
									CafeReporter "ViewMD_ValidateTimeSeries","Submit Metered Data - TimeSeries","Fail","Expected" & Exp_rwcnt & " Rows of time series enteries","Actual '" & Trim(rcount) &"' rows of time series are displayed."
								End If								
								
								
								For i = 0 To Ubound(ArrayCheck)					
										Ex_period  		= Exp_date &" "& Trim(ArrayCheck(i))				'Expected Values
										Ex_Val	   		= Cdbl(Replace(Trim(Val),".",","))
										Ex_Quan_Qual	= Trim(Quan_Qual)									
																											'Actual Values	
										period 		= Trim(.GetCellData(i+3,1))
										AcVal    	= Cdbl(Replace(Trim(.GetCellData(i+3,2)),".",","))	'To Support Danish Numbering system since OS language is Dansk. Moreover using Double since the value is returned with 3 decimal points.
										Quan_Qlty 	= Trim(.GetCellData(i+3,3))
										
		
										If StrComp(Trim(Ex_period),period,0) <> 0 OR Eval(Ex_Val=AcVal) <> True OR Strcomp(Ex_Quan_Qual,Quan_Qlty,1) <> 0  Then																						
											CafeReporter "ViewMD_ValidateTimeSeries","Submit Metered Data - TimeSeries","Fail","Expected Period: " & Ex_period &", Value: '"& Ex_Val &"', Quantity_Quality: '" & Ex_Quan_Qual &"'","Actual Period: " & period &", Value: '"& AcVal &"', Quantity_Quality: '" & Quan_Qlty &"'"												
											Err_Cmp = True 
										End If
								Next
										If Err_Cmp = False Then											
											CafeReporter "ViewMD_ValidateTimeSeries","Submit Metered Data - TimeSeries","Pass","Expected " & Exp_rwcnt & " rows of time series enteries with Value: "& Ex_Val &", Quantity_Quality:" & Ex_Quan_Qual,"As expected displayed." 
										End If
										
									'CHECK SUM
									RowNAmeSum =  .GetCellData(rcount,1)	
		
										If Strcomp(Trim(RowNAmeSum),"Sum",1) = 0  Then
							
											RowValSum =  .GetCellData (rcount,2)
							
											If  Cdbl(Replace(Trim(RowValSum),".",",")) = Cdbl(rEplace(Environment.value("SumValue"),".",","))  Then
												CafeReporter "MonitorMP_ViewSeriesMeterDataResult","MonitorMP_ViewSeriesMeterDataResult" ,"Pass","Sum Value  is as expected " ,"Yes"
											Else
											CafeReporter "MonitorMP_ViewSeriesMeterDataResult","MonitorMP_ViewSeriesMeterDataResult" ,"Fail","Sum Value  is as expected ","Nope. Actual Value :: " & RowValSum & "Expected Value :" & Environment.value("SumValue")
										End If
									End If 									
								
					End With

'					
								
If Err.Number <> 0 Then
		CafeReporter "SubmitMPTime_VerifyMeterData","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If 	
	
	
End Function

'************************************************************************************************************************************************
'Function Name: SubmitMeterReading_VerifyMeteringData((vEnergyQuantity,vQualityQuantity)
'Function Desc   :Verify the Metering Data of a particular MP 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SubmitMeterReading_VerifyMeteringData("1000","CONSUMPTION")
'Author: Supriya
'Created Date : 03-09-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function SubmitMeterReading_VerifyMeteringData(vEnergyQuantity,vQualityQuantity)
	On Error Resume Next 
	

				Rcnt = Browser("Datahub").Page("View metering data").WebTable("Start date").RowCount
					
					If Rcnt > 1  Then
						CafeReporter "SubmitMeterReading_VerifyMeteringData","SubmitMeterReading_VerifyMeteringData" ,"Pass","Result  Table with Data is displayed" ,"Yes"
						vActEnergyQuant 	= Browser("Datahub").Page("View metering data").WebTable("Start date").GetCellData(3,3)
						vActQualityQuantity = Browser("Datahub").Page("View metering data").WebTable("Start date").GetCellData(3,4)

						
						
						If Trim(vActEnergyQuant) = Trim(vEnergyQuantity)  Then
							CafeReporter "SubmitMeterReading_VerifyMeteringData","SubmitMeterReading_VerifyMeteringData" ,"Pass","Consumption is as expected" ,"Yes"
						Else
							CafeReporter "SubmitMeterReading_VerifyMeteringData","SubmitMeterReading_VerifyMeteringData" ,"Fail","Consumption is as expected ." ,"Nope. Actual EnergyQuantity :=" & vActEnergyQuant & "Expected := " & vEnergyQuantity 						
							
						End If
						
						
						If Strcomp(Ucase(Trim(vQualityQuantity)) ,Ucase(Trim(vActQualityQuantity)),1) = 0   Then
							CafeReporter "SubmitMeterReading_VerifyMeteringData","SubmitMeterReading_VerifyMeteringData" ,"Pass","Quality Quantity is as expected " ,"Yes"
						Else
							CafeReporter "SubmitMeterReading_VerifyMeteringData","SubmitMeterReading_VerifyMeteringData" ,"Fail","Quality Quantity is as expected ." ,"Nope.Actual QualityQuantity := " & vActQualityQuantity & "Expected:= " & vQualityQuantity						
							
						End If
						
						
						
					Else
						CafeReporter "SubmitMeterReading_VerifyMeteringData","SubmitMeterReading_VerifyMeteringData" ,"Fail"," Result Table with Data should be displayed " ,"Nope.No Records Found "					
					
					End If 
					
If Err.Number <> 0 Then
		CafeReporter "SubmitMeterReading_VerifyMeteringData","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If 	
						
End Function


'************************************************************************************************************************************************
'Function Name: MonitorMP_VerifyReferenceCreated()
'Function Desc   :Verifies the  the Reference created for MP with 15 Mins 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : MonitorMP_VerifyReferenceCreated()
'Author: Supriya
'Created Date : 03-09-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function MonitorMP_VerifyReferenceCreated()
On Error Resume Next
					
					'CODE
					
					
					If Browser("Datahub").Page("Monitor time series").WbfGrid("ResultGrid").Exist(30) Then
						
						Rwcnt = Browser("Datahub").Page("Monitor time series").WbfGrid("ResultGrid").RowCount
						
						
						If Rwcnt  > 0    Then
'							
									If Rwcnt = 3 Then
													CafeReporter "MonitorMP_VerifyReferenceCreated","MonitorMP_VerifyReferenceCreated" ,"Pass","two time Series REferences have been created as expeceted " ,"Yes." 
																										
													vGetVal = Browser("Datahub").Page("Monitor time series").WbfGrid("ResultGrid").GetCellData(3,6)
													vExpRowVal = "Calculated from 15 min values"
													If StrComp(Trim(vGetVal),vExpRowVal) = 0  Then
															CafeReporter "MonitorMP_VerifyReferenceCreated","MonitorMP_VerifyReferenceCreated" ,"Pass","Reference is as Expected " ,"Yes." & vGetVal 
															Else
															CafeReporter "MonitorMP_VerifyReferenceCreated","MonitorMP_VerifyReferenceCreated" ,"Fail","Reference is as Expected ","Nope.Expected Reference :- " & vExpRowVal & "Actual reeference:-" & vGetVal 
														
													End If
													
'										
									Else
													CafeReporter "MonitorMP_VerifyReferenceCreated","MonitorMP_VerifyReferenceCreated" ,"Fail","Two time Series REferences have been created as expeceted " ,"Nope." 
									End If	
					

						 
						End If
					End If
	
If Err.Number <> 0 Then
		CafeReporter "MonitorMP_VerifySearch","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If 	
	
	
End Function

'************************************************************************************************************************************************
'Function Name: MonitorMP_ViewSeriesMPResult()
'Function Desc   :Verifies the  the time series monitored  
'Arguments: Uses Cafe framework
'Return : Nil
'Example : MonitorMP_ViewSeriesMPResult()
'Author: Supriya
'Created Date : 03-09-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function MonitorMP_ViewSeriesMPResult(vDisplayResolution,Exp_Status)
On Error Resume NEXT

				Browser("Datahub").Page("Monitor time series").WbfGrid("ResultGrid").ClickCell 2,7
								'1.0 DATA
'						 		vDisplayResolution = Environment.Value("ResolutionSearch")
						 		 
						 		
								 '2.0 CODE
								 
								 Select Case Ucase(vDisplayResolution)
								 	
								 	Case "HOUR"
								 		vResolution = "60"
								 	
								 	Case "15 MINUTES"
								 	
								 		vResolution = "15"
								 	Case "MONTH"
								 		vResolution = "1"
								 	
								 End Select
						 
						 		'3.0  CHECK THE VALUES 
								RwcntMP = Browser("Datahub").Page("Monitor time series").Frame("Frame").WebTable("Metering point").RowCount	   
'								 
								If RwcntMP > 0  Then
								For Iterator = 1 To RwcntMP - 1 Step 1
									
								
									RowName =  Browser("Datahub").Page("Monitor time series").Frame("Frame").WebTable("Metering point").GetCellData(Iterator,1)
									RowVal = Browser("Datahub").Page("Monitor time series").Frame("Frame").WebTable("Metering point").GetCellData(Iterator,2)
									Select Case(Trim(RowName))
										
										Case "Metering point"
											If Strcomp(Trim(RowVal),Trim(Environment.Value("MeteringPointSearch")),1) = 0  Then
													CafeReporter "MonitorMP_ViewSeriesMPResult","MonitorMP_ViewSeriesMPResult" ,"Pass","MeteringPointID is as expected " ,"Yes"
											Else
													CafeReporter "MonitorMP_ViewSeriesMPResult","MonitorMP_ViewSeriesMPResult" ,"Fail","MeteringPointID is as expected ","Nope"		
											
											End If
										
										
										
										Case "Start date"
											Exp_StartDate = GETXML("SUBMITMP_TIME","PERIODFROM_DATE")'
											If Strcomp(Trim(RowVal),Exp_StartDate,0) = 0 Then 
													CafeReporter "MonitorMP_ViewSeriesMPResult","MonitorMP_ViewSeriesMPResult" ,"Pass","Start Date is as expected " ,"Yes"
											Else
													CafeReporter "MonitorMP_ViewSeriesMPResult","MonitorMP_ViewSeriesMPResult" ,"Fail","Start Date is as expected ","Nope"		
											
												
											End If
										
										
										
										Case "End date"
											Exp_EndDate = DateAdd("d",1,GETXML("SUBMITMP_TIME","PERIODFROM_DATE") )
											If strComp(Trim(Cdate(RowVal)),Exp_EndDate,0) = 0  Then  'Cdate(Trim(Environment.Value("PeriodToSearch")))  Then
												CafeReporter "MonitorMP_ViewSeriesMPResult","MonitorMP_ViewSeriesMPResult" ,"Pass","End Date is as expected " ,"Yes"
											Else
												CafeReporter "MonitorMP_ViewSeriesMPResult","MonitorMP_ViewSeriesMPResult" ,"Fail","End Date is as expected ","Nope"		
											End If
										
										
										Case  "Status"
										
											If Strcomp(Trim(RowVal),Exp_Status,1) = 0  Then
												CafeReporter "MonitorMP_ViewSeriesMPResult","MonitorMP_ViewSeriesMPResult" ,"Pass","Status is as expected " ,"Yes"
											Else
												CafeReporter "MonitorMP_ViewSeriesMPResult","MonitorMP_ViewSeriesMPResult" ,"Fail","Status is as expected ","Nope.Expecteed Status :: Time Series processed without errors. Actual Status :: " & RowVal										
											End If
											
										Case "Resolution"	
											If  Trim(RowVal) =  vResolution Then
												CafeReporter "MonitorMP_ViewSeriesMPResult","MonitorMP_ViewSeriesMPResult" ,"Pass","Resolution is as expected " ,"Yes"
											Else
												CafeReporter "MonitorMP_ViewSeriesMPResult","MonitorMP_ViewSeriesMPResult" ,"Fail","Resolution is as expected ","Nope.Expecteed Resolution :: " & vResolution& " Actual Resolution :: " & RowVal		
																			 
											End If
										
										
									End Select
									
								Next
								
	If Err.Number <> 0 Then
		CafeReporter "MonitorMP_ViewSeriesMPResult","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If 	
	
End If 	
	
End Function

'************************************************************************************************************************************************
'Function Name: MonitorMP_ViewSeriesMeterDataResult(Byval Val,Byval Quan_Qual,Byval Resolution)
'Function Desc   :Verifies the  the time series monitored  
'Arguments: Uses Cafe framework
'Return : Nil
'Example : MonitorMP_ViewSeriesMeterDataResult("2","MEASURED","HOUR")
'Author: Supriya
'Created Date : 03-09-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function MonitorMP_ViewSeriesMeterDataResult(Byval Val,Byval Quan_Qual,Byval Resolution )

On eRROR rESUME nEXT

Err_Cmp = False 'Flag for Error

	 	 			Dt = GETXML("SUBMITMP_TIME","PERIODFROM_DATE")		'Get the Period Date
					Dt_chgFormat = Split(dt,"/")
					
	 	 
					Hour_Array = Split(GetXML("ISCALC","Hour_Reading"),",")
					Minute_Array = Split(GetXML("ISCALC","MINUTE_READING"),",")
					Month_Array = Array("2014-"& Month(GETXML( "SUBMITMP_TIME")))
					
					Select Case Ucase(Resolution)
						Case "HOUR"
						
						Check_Array =  Hour_Array
						Exp_rwcnt = 24   
						Exp_Dt  = replace(Dt,"-","/")
						
						Case "15 MINUTES"
						
						Check_Array =  Minute_Array
						Exp_rwcnt = 96
						Exp_Dt  = replace(Dt,"-","/")
'						
						Case "MONTH"
						Check_Array =  Month_Array
						Exp_rwcnt = 1
						Exp_Dt  = ""
				
						
						
					End Select
	
'					 
					With Browser("Datahub").Page("Monitor time series").Frame("Frame").WbfGrid("ViewSeriesResultGrid")
					
								.Exist(15) 'Sync								
								rcount = .RowCount		'This method adds the row of header and table border to the count by default. So the actual row count of record is "rcount -2"
								
								
								If rcount-2 <> Ubound(Check_Array)+1 Then		'Validate whether the row counts reflect 24 hours enteries.	
									CafeReporter "MonitorMPViewMD_ValidateTimeSeries","Monito Mp - TimeSeries","Fail","Expected " &Exp_rwcnt & " Rows of time series enteries","Actual '" & Trim(rcount) &"' rows of time series are displayed."
								End If

								
								For i = 0 To Ubound(Hour_Array)					
										Ex_period  		= Exp_Dt &" "& Trim(Check_Array(i))				'Expected Values
										Ex_Val	   		= Cdbl(Replace(Trim(Val),".",","))
										Ex_Quan_Qual	= Trim(Quan_Qual)									
																											'Actual Values	
										period 		= Trim(.GetCellData(i+2,1))
										AcVal    	= Cdbl(Replace(Trim(.GetCellData(i+2,2)),".",","))	'To Support Danish Numbering system since OS language is Dansk. Moreover using Double since the value is returned with 3 decimal points.
										Quan_Qlty 	= Trim(.GetCellData(i+2,4))
										
		
										If StrComp(Ex_period,period,0) <> 0 OR Eval(Ex_Val=AcVal) <> True OR Strcomp(Ex_Quan_Qual,Quan_Qlty,1) <> 0  Then																						
											CafeReporter "MonitorMP_ViewSeriesMeterDataResult","MonitorMP - TimeSeries","Fail","Expected Period: " & Ex_period &", Value: '"& Ex_Val &"', Quantity_Quality: '" & Ex_Quan_Qual &"'","Actual Period: " & period &", Value: '"& AcVal &"', Quantity_Quality: '" & Quan_Qlty &"'"												
											Err_Cmp = True 
										End If
								Next
										If Err_Cmp = False Then											
											CafeReporter "MonitorMP_ViewSeriesMeterDataResult","MonitorMP - TimeSeries","Pass","All Expected :" & Exp_rwcnt &" rows of time series enteries with Value: "& Ex_Val &", Quantity_Quality:" & Ex_Quan_Qual,"As expected displayed." 
										End If
								
					
					
								'  CHECK THE SUM
									RowNAmeSum =  .GetCellData(rcount,1)	
		
										If Strcomp(Trim(RowNAmeSum),"Sum",1) = 0  Then
							
											RowValSum =  .GetCellData (rcount,2)
							
											If  Cdbl(Replace(Trim(RowValSum),".",",")) = Cdbl(rEplace(Environment.value("SumValue"),".",","))  Then
												CafeReporter "MonitorMP_ViewSeriesMeterDataResult","MonitorMP_ViewSeriesMeterDataResult" ,"Pass","Sum Value  is as expected " ,"Yes"
											Else
											CafeReporter "MonitorMP_ViewSeriesMeterDataResult","MonitorMP_ViewSeriesMeterDataResult" ,"Fail","Sum Value  is as expected ","Nope. Actual Value :: " & RowValSum & "Expected Value :" & Environment.value("SumValue")
										End If
									End If 
					End With
					Browser("Datahub").Page("Monitor time series").Image("Close").Click

'		


	If Err.Number <> 0 Then
		CafeReporter "MonitorMP_ViewSeriesMeterDataResult","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If 	


End Function

'************************************************************************************************************************************************
'Function Name: CMP_DownloadMeteredData()
'Function Desc   :Downloads Metered data using Download.csv
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CMP_DownloadMeteredData()
'Author: Supriya
'Created Date :  25-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	


Function  CMP_DownloadMeteredData()
	On Error Resume Next 
	
	 									
				'1.0 SCREEN
				
										
					Browser("Datahub").Page("View metering point").Link("Metering data").Engine("#CLICK--2")
					Browser("Datahub").Page("View metering data").Link("Metered data").Engine("#CLICK--2")

					Browser("Datahub").Page("View metering data").WebElement("DownloadCSV").Engine("#CLICK--10")
'					SystemUtil.CloseProcessByName("excel.exe")
'					InvokeApplication "C:\Program Files (x86)\Microsoft Office\Office14\EXCEL.exe"
SystemUtil.Run "C:\Program Files (x86)\Microsoft Office\Office14\EXCEL.exe","","","",3
wait 10 
					
					Browser("Datahub").WinObject("Notification bar").WinButton("Open").Click
					

	
	'
	
	If Err.Number <> 0 Then
		CafeReporter "CMP_DownloadMeteredData","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If 	


	
	
End Function


'************************************************************************************************************************************************
'Function Name: CDownloadCSV_GetExcelName()
'Function Desc   :Verifies the downloaded excel file 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CDownloadCSV_GetExcelName()
'Author: Supriya
'Created Date :  25-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	

Function CDownloadCSV_GetExcelName()
 

	
 
	On Error Resume Next

			Dim objXL, WB, strMessage	
			wait 20 'Sync with opening of excel sheet 
			Set objXL=CreateObject("Excel.Application")
			Set objXL =Eval("GetObject(, ""Excel.Application"")") 'Get the instance of excel object of the excel sheet which is open 
			Set WB = objXL.ActiveWorkbook
			print objXL.ActiveWorkbook.Name
			On Error GoTo 0
						If Not TypeName(objXL) = "Empty" Then
						
									    If Not TypeName(WB) = "Nothing" Then
									    
									  		 print  "Excel Running - " & objXL.ActiveWorkbook.Name & " is active"
									  		
									  		 vGetExcelName = objXL.ActiveWorkbook.Name
									  		 If Instr(vGetExcelName,Environment.Value("MeteringPoint")) > 0  Then 
									  		 	CafeReporter "CDownloadCSV_GetExcelName","CDownloadCSV_GetExcelName","Pass","Downloading CSV  is succesful and the document is as expected .","Yes"
									  		 End If

									  		 
									    Else
									    
											print "Excel Running - no workbooks open"
											CafeReporter "CDownloadCSV_GetExcelName","CDownloadCSV_GetExcelName","Fail","Downloading CSV  is succesful and the document is as expected .","Nope.Excel Running - no workbooks open"
											
									    End If
						    
						    
						Else
							 
						  	 print "Excel NOT Running"	
							CafeReporter "CDownloadCSV_GetExcelName","CDownloadCSV_GetExcelName","Fail","Downloading CSV  is succesful and the document is as expected .","Nope.Excel  Not Running - no workbooks open.Error Description :-" & Err.Description 
											
									   					  	 
				
						 
						End If
						 
		 		
			'objXL.ActiveWorkbook.Close
			'objXL.Quit
				 
			Set objXL = Nothing			
			SystemUtil.CloseProcessByName("excel.exe")
		    CDownloadCSV_GetExcelName = vGetExcelName
		    
	If Err.Number <> 0  Then
		CafeReporter "CDownloadCSV_GetExcelName","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""
	
	End If 	

	
	
End Function



'************************************************************************************************************************************************
'Function Name: CMP_VerifyHistMPBTDSTEP()
'Function Desc   :Verifies the BTD Step of hist  Mp Created 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CMP_VerifyHistMPBTDSTEP()
'Author: Supriya
'Created Date :  22-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function CMP_VerifyHistMPBTDSTEP()
	
	On error resume next 

							'1.0   DATA 
 							
 							With Browser("Datahub").Page("View business transactions").WebTable("BusinessTransactionStepsGrid")
									.CheckBTDStep "Create Historical Metering Point Request","Received","2"
									.CheckBTDStep "Create Historical Metering Point Approval","Implicit","2"
									
							End With 





If Err.Number <> 0 Then
		CafeReporter "CMP_VerifyHistMPBTDSTEP","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If
End Function


'************************************************************************************************************************************************
'Function Name: CMP_VerifyHistMPBTDSTEP()
'Function Desc   :Verifies the BTD Step of hist  Mp Created 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CMP_VerifyHistMPBTDSTEP()
'Author: Supriya
'Created Date :  22-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function CEditMP_VerifyBTD()
	
	On error resume next 

							'1.0   DATA 
 							
 							With Browser("Datahub").Page("View business transactions").WebTable("BusinessTransactionStepsGrid")
									.CheckBTDStep "Update Historical Metering Point Request","Received","2"
									.CheckBTDStep "Update Historical Metering Point Approval","Implicit","2"
									
							End With 





If Err.Number <> 0 Then
		CafeReporter "CEditMP_VerifyBTD","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If
End Function


	
'************************************************************************************************************************************************
'Function Name: CMP_GenWebAccCodeInactive()
'Function Desc   :Generates Web Access Code for Inactive MP 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CMP_GenWebAccCodeInactive()
'Author: Supriya
'Created Date :  22-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	
 

Function CMP_GenWebAccCodeInactive()
	
On Error REsume Next


							'1.0 DATA
							vEffectuationDate = getDate_DDMMYYYY()
'													
							
							'2.0 SCREEN
							With Browser("Datahub").Page("View metering point")
									
									.WebElement("Generate web access code").Engine("#CLICK--2")
									.Frame("ViewMP").Engine("#EXIST--Y")
									.Frame("ViewMP").WebEdit("EffectuationDate").Engine(vEffectuationDate)
						 			.Frame("ViewMP").WebElement("SubmitButton").Engine("#CLICK--2||@CWebAccess_VerifyErrMsg()")
						 			.Frame("ViewMP").WebElement("Cancel").Engine("#CLICK--2")
									
				 			
				 			End With 

				


If Err.Number <> 0 Then
		CafeReporter "CMP_GenWebAccCodeInactive","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
End If 
	
End Function


'************************************************************************************************************************************************
'Function Name: CMP_VerifyGenAccBTDSTEP()
'Function Desc   :Verify the Business Transaction Step after genearting the access code  
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CMP_VerifyGenAccBTDSTEP()
'Author: Supriya
'Created Date :  08-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function CMP_VerifyGenAccBTDSTEP()
	
	On error resume next 

							'1.0   DATA 
 							
 							With Browser("Datahub").Page("View business transactions").WebTable("BusinessTransactionStepsGrid")
									.CheckBTDStep "Manual web access code generation Rejection","Dequeued","2"
								 
									
							End With 





If Err.Number <> 0 Then
		CafeReporter "CMP_VerifyGenAccBTDSTEP","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If
End Function
'************************************************************************************************************************************************
'Function Name: CWebAccess_VerifyErrMsg()
'Function Desc   :Verifies Err Msg from WEb Access Code 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CWebAccess_VerifyErrMsg()
'Author: Supriya
'Created Date :  25-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	


Function CWebAccess_VerifyErrMsg()
On Error Resume Next 

							'1.0 Check Error Message
							
							vErrMsg = Browser("Datahub").Page("View metering point").Frame("ViewMP").WebElement("Rejection_ErrMsg").GetROProperty("innertext")	'Actual Error message
							Exp_Err_Msg = GetXML("CREATE_WEBACCESSCODE","ERR_MSG") 	'Expected Error Msg
							
							
							'2.0 REPORT 
							If Instr(Trim(vErrMsg),Trim(Exp_Err_Msg))  > 0 Then
									CafeReporter "CWebAccess_VerifyErrMsg","Inactive MP web Acccess Code ","Pass","Expected Error Message '" & vErrMsg &"' was displayed.","Yes"					
								Else
									CafeReporter "CWebAccess_VerifyErrMsg","Inactive MP web Acccess Code","Pass","Expected Error Message was displayed.","No. Expected Message = '" & Exp_Err_Msg & "', Actual Msg =' " & vErrMsg &"'"					
							End If
	
If Err.Number <> 0 Then
		CafeReporter "CWebAccess_VerifyErrMsg","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
End If 
	
End Function

'************************************************************************************************************************************************
'Function Name: CGenAccCode_VerifyMPBTDSTEPErr()
'Function Desc   :Verifies BTD STep  Error message 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CGenAccCode_VerifyMP
 
'Author: Supriya
'Created Date :  25-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	

Function CGenAccCode_VerifyMPBTDSTEPErr()

On Error Resume Next 


					
						Browser("Datahub").Page("View business transactions").WebTable("BusinessTransactionStepsGrid").ChildItem(3,5,"Link",0).Click
						strText = Browser("Datahub").Page("View business transactions").Frame("ViewBusinessTrans").WebTable("ErrTable").GetCellData(1,1)
							'Check if Error Exists 
							If Instr(strText,"Error message") > 0  Then
									PosErr = Instr(strText,"Error message") 
									strErr = Mid(strText,PosErr + len("Error message"))	
									Exp_Err_Msg = GetXML("CREATE_WEBACCESSCODE","ERR_MSG") 	'Expected Error Msg
															
											If Instr(Trim(strErr),Trim(Exp_Err_Msg))  > 0 Then
													CafeReporter "CGenAccCode_VerifyMPBTDSTEPErr","CGenAccCode_VerifyMPBTDSTEPErr ","Pass","Expected Error Message '" & strErr &"' was displayed.","Yes"					
												Else
													CafeReporter "CGenAccCode_VerifyMPBTDSTEPErr","CGenAccCode_VerifyMPBTDSTEPErr","Fail","Expected Error Message was displayed.","No. Expected Message = '" & Exp_Err_Msg & "', Actual Msg =' " & strErr &"'"					
											End If					
										
									End If 
					

				
		
	If Err.Number <> 0 Then
		CafeReporter "CGenAccCode_VerifyMPBTDSTEPErr","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If 		
			
		
	
End Function
 



'************************************************************************************************************************************************
'Function Name: SearchMP_ValidateErrMsg()
'Function Desc   :Validates error Message for Search MP 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SearchMP_ValidateErrMsg()
'Author: Supriya
'Created Date :  26-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	
	
	

 Function SearchMP_ValidateErrMsg()
 On Error Resume Next 
 
 		'GET ERROR MESSAGE 
 		
		 		vErrMsg = Browser("Datahub").Page("Search metering point").WebElement("ErrMsgLabel").GetROProperty("innertext")
		 		Exp_Err_Msg  = GETXML("SEARCH_MP","ERRMSG")
 		
 		
		'REPORT
		
		 		If Instr(Trim(vErrMsg),Trim(Exp_Err_Msg)) > 0 Then
					CafeReporter "SearchMP_ValidateErrMsg","SearchMP_ValidateErrMsg","Pass","Expected Error Message '" & Exp_Err_Msg &"' was displayed.","Yes"					
				Else
					CafeReporter "SearchMP_ValidateErrMsg","SearchMP_ValidateErrMsg","Fail","Expected Error Message was displayed.","No. Expected Message = '" & Exp_Err_Msg & "', Actual Msg =' " & vErrMsg &"'"					
				End If
		 
 	
 	
 	If Err.Number <> 0 Then
		CafeReporter "SearchMP_ValidateErrMsg","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If 	
 	
 End Function
 
'************************************************************************************************************************************************
'Function Name: SearchMPasNO_ValidateMP()
'Function Desc   :Validates MP AS NON OWNER 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : SearchMPasNO_ValidateMP()
'Author: Supriya
'Created Date :  26-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	
	

Function SearchMPasNO_ValidateSearch()
	 On Error Resume Next 
	 
	 					'1.0 TABLE
	 						Table     = GetXML("SEARCH_MP","TABLE") 'Environment.Value("ScriptID")
							vScriptID = GetXML("SEARCH_MP","SCRIPT_ID")  'Environment.Value("ScriptID")
							vStep     = GetXML("SEARCH_MP","STEP") 'Environment.Value("ScriptID")
						
						
						
						'1.1 QUERY
						 	StrSQL = "Select * from " & Trim(Table) & " where Script_ID = '"& Trim(vScriptID) & "' and Step = '" & Trim(vStep) &"'"
						
						
						'2.0 DATADICTIONARY		
							 GetRecord(StrSQL)
							 
							 vConsumerName						= Trim(GetRecord_Ddict.Item(Ucase("ConsumerName")))
							 vStreetName						= Trim(GetRecord_Ddict.Item(Ucase("StreetName")))
						 
						 '3.0 SCREEN
						 
						 '3.0.1 Click on the First MP id 
						 	RowCount = Browser("Datahub").Page("Search metering point").WebTable("Metering point ID").RowCount
						 	If RowCount > 0  Then
						 		CafeReporter "SearchMPasNO_ValidateMSearch","SearchMPasNO_ValidateMSearch","Pass","Number of Search Results found :: '" & RowCount - 1 &"'","Yes"
						 		Browser("Datahub").Page("Search metering point").WebTable("Metering point ID").ChildItem(3,1,"Link",0).Click
						 	
						 	
						 	
										 '3.0.2 Validate Search 	
										
											If Browser("Datahub").Page("View metering point").Exist(100) Then							
													Browser("Datahub").Page("View metering point").WebElement("ExpandAllButton").Click	
											End If 
										
										
											 'Consumername
											 With Browser("Datahub").Page("View metering point").WebTable("Market Details")
													 If Instr(vConsumerName,"%") > 0   Then
													
															vConsumerName = Replace(vConsumerName,"%","")									
															.CheckMPWildcardCh "First consumer party name",vConsumerName							
															
													 Else
													 		.CheckMPDetails "First consumer party name",vConsumerName	
													 End If
											 End With
							 
							 
							 
											 'Streetname
											 With Browser("Datahub").Page("View metering point").WebTable("Location Detail")
													 If Instr(vStreetName,"%") > 0   Then
													
															vStreetName = Replace(vStreetName,"%","")									
															.CheckMPWildcardCh "Street name",vStreetName							
															
													 Else
													 		.CheckMPDetails "Street name",vStreetName	
													 End If
											 End With
						 
						
						 	Else
								CafeReporter "SearchMPasNO_ValidateSearch","SearchMPasNO_ValidateSearch","Pass"," Search Results should be displayed","Nope"						 	
						 	End If
 	
	 	If Err.Number <> 0 Then
			CafeReporter "SearchMPasNO_ValidateSearch","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
		End If 	
 	
	
	
End Function

'************************************************************************************************************************************************
'Function Name: CheckMPWildcardCh()
'Function Desc   :Validates every field of MP  
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CheckMPWildcardCh()
'Author: Supriya
'Created Date :  26-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	
	

Function CheckMPWildcardCh(ByRef obj, ByVal vColName, ByVal RowVal)
	
	On Error Resume Next
					
					If IsNull(RowVal) or IsEmpty(RowVal) or RowVal = "" or RowVal = " " Then	'Exit function if parameter is null.						
						Exit Function						
					End If	
					
					
					
					'Get Table Name
					vtableName = obj.GetTOProperty("TestObjName")
					
					
					For i = 1 To obj.RowCount
					
						If Strcomp(Trim(vColName),Trim(obj.GetCellData(i,1)),1) = 0 Then
							RowNumber  = i
							Exit For
							Else
							If i = Obj.RowCount Then
								'CafeReporter "CheckMPDetails","In Table: " & vtableName & ", Column: '" & vColName & ".","Fail","Column '"  & vColName & "' should be found within this table.","Not found"
								Exit Function
							End If							
						End If
						
					Next
	 
					CellVal = Obj.GetCellData(Trim(RowNumber),2)
					ColVal =  Obj.GetCellData(Trim(RowNumber),1)
					
					 
									If Instr(1,Trim(RowVal),Trim(CellVal),1) > 0 Then
										CafeReporter "CheckMPWildcardCh","View Metering Point, Table : " & vtableName ,"Pass","Details mentioned in '" & Trim(ColVal) & "' is as expected.","Yes"					
										Else
										CafeReporter "CheckMPWildcardCh","View Metering Point, Table : " & vtableName ,"Fail","Details mentioned in '" & Trim(ColVal) & "' is as expected.","Nope. Expected Value = '" & Trim(RowVal) &"', Actual Value = '"  & Trim(CellVal) &"'"					
										Err.Number = 2000
										Err.Description = "View Metering Point, Failure in data comparison. Table : " & vtableName
									End If	
	If Err.Number <> 0 Then
			CafeReporter "CheckMPWildcardCh","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
		End If 	
End Function 
 '************************************************************************************************************************************************
'Function Name: CMP_UpdateMPNonRegulated()
'Function Desc   : Updates Non Regulated Field for an MP such as Physical Status 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CMP_UpdateMPNonRegulated()
'Author: Supriya
'Created Date :  26-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	
	

Function CMP_UpdateMPNonRegulated()
On error Resume Next 


	'1.0SCREEN	
	With Browser("Datahub").Page("View metering point")
 			 .WebElement("UpdateNRField").Engine("#EXIST--Y")
 			 .WebElement("UpdateNRField").Click 			 
  		  	 .Frame("ViewMP").WebRadioGroup("PhysicalMPRadioBtn").Engine("@CUpdateNR_SelectPhysicalstatus()")
			 .Frame("ViewMP").WebElement("SubmitButton").Engine("#CLICK--2")
	End With 



If Err.Number <> 0 Then
			CafeReporter "CMP_UpdateMPNonRegulated","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
End If 	
	
End Function


 '************************************************************************************************************************************************
'Function Name: CUpdateNR_SelectPhysicalstatus()
'Function Desc   : Selects the Physical Status . If Yes , then  chooses No  and vice versa
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CUpdateNR_SelectPhysicalstatus()
'Author: Supriya
'Created Date :  26-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	
	
Function CUpdateNR_SelectPhysicalstatus()
On error Resume Next 

			'1.0 Find the Index whihc is checked 
				vSelindex = Browser("Datahub").Page("View metering point").Frame("ViewMP").WebRadioGroup("PhysicalMPRadioBtn").GetROProperty("selected item index")
				 
				
			'2.0 nSelects the Physical status according to the index which is lareday selected . i.e if Yes is selected by default then the  selection is set to  No	
			If vSelindex = 1 Then
				Environment.Value("PhysicalStatusSet") = "No"
				Browser("Datahub").Page("View metering point").Frame("ViewMP").WebRadioGroup("PhysicalMPRadioBtn").Select "PhysicalMeteringPointNo"
				wait 10
			Else
				Browser("Datahub").Page("View metering point").Frame("ViewMP").WebRadioGroup("PhysicalMPRadioBtn").Select "PhysicalMeteringPointYes"
				Environment.Value("PhysicalStatusSet") = "Yes" 
				wait 10
			End If
			
If Err.Number <> 0 Then
			CafeReporter "CUpdateNR_SelectPhysicalstatus","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
End If 			
			
End Function

 '************************************************************************************************************************************************
'Function Name: CUpdateNR_ChkPhysicalstatus()
'Function Desc   : Checks  the Physical Statusof MP is set  correctly via Update NR field 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CUpdateNR_SelectPhysicalstatus()
'Author: SupriyaCUpdateNR_ChkPhysicalstatus
'Created Date :  26-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	
	



Function CUpdateNR_ChkPhysicalstatus()

On Error Resume Next 
			
			'EXPECTED PHYSICAL STATUS 
			vExpected_PStatus = Environment.Value("PhysicalStatusSet")
			
			If Browser("Datahub").Page("View metering point").Exist(100) Then							
					Browser("Datahub").Page("View metering point").WebElement("ExpandAllButton").Click	
			End If
			
			
			'VERIFIE THE PHYSICAL STATUS 
			With Browser("Datahub").Page("View metering point").WebTable("Physical Detail")
					
						.CheckMPDetails "Physical metering point",vExpected_PStatus 
									  							
									
			End With
	
	
	
If Err.Number <> 0 Then
			CafeReporter "CUpdateNR_ChkPhysicalstatus","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
End If 			
			
	
End Function

 '************************************************************************************************************************************************
'Function Name: CMoveIn_VerifyMsg()
'Function Desc   : Verifies the succes message 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CMoveIn_VerifyMsg()
'Author: Supriya 
'Created Date :  10-09-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************	
	
	
	Function CMoveIn_VerifyMsg()
 
		
		 
	On Error Resume Next 
			' Success Message Verification
				vMsg = Browser("Datahub").Page("View metering point").WebElement("SuccessMsgLabel").GetROProperty("innertext")				
				vSuccessMsg = GetXML("CREATE_SPLMP","SUCCESS_MSG")
				
				
				If StrComp(vMsg,vSuccessMsg,1) = 0 Then
					CafeReporter "CMoveIn_VerifyMsg","CMoveIn_VerifyMsg","Pass","Successs Message is displayed ::" & CMoveIn_VerifyMsg  ,"Yes"					
					Else	
					CafeReporter "CMoveIn_VerifyMsg","CMoveIn_VerifyMsg","Fail","Successs Message is displayed ","Nope"					
				End If
								
	 If Err.Number <> 0 Then
			CafeReporter "CMoveIn_VerifyMsg","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	 End If 						
								
								
	End Function 
									

'************************************************************************************************************************************************
'Function Name: OTrans_ClickStepType()
'Function Desc   :Clicks  a step of Open Transaction 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : OTrans_ClickStepType()
'Author: Supriya
'Created Date :  
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************



Function OTrans_ClickStepType()

On error Resume Next 


		ExpStep = GETXML("OPEN_TRANS","STEP_TYPE")
		RwcnTrans = Browser("Datahub").Page("Open transaction list").WbfGrid("ResultGrid").RowCount

		If RwcnTrans > 0  Then
		
			CafeReporter "OTrans_ClickStepType","OTrans_ClickStepType","Pass","Transaction List found for the given MP . RowCount ::" &RwcnTrans ,"Yes"	
			
			
		
				For Iterator = 2 To RwcnTrans Step 1
				
								ActStep = Browser("Datahub").Page("Open transaction list").WbfGrid("ResultGrid").GetCellData(Iterator,4)
					
								If Strcomp(ExpStep,ActStep,1) = 0   Then
										
										CafeReporter "OTrans_ClickStepType","OTrans_ClickStepType","Pass","Step Type is found as desired","Yes"							
						  	 			Browser("Datahub").Page("Open transaction list").WbfGrid("ResultGrid").ChildItem(Iterator,4,"Link",0).Engine("#CLICK--2")
						  	 			Exit For 
						  	 	'						 	
								End If 
							
					 
				Next
		Else
			CafeReporter "OTrans_ClickStepType","OTrans_ClickStepType","fail","Transaction List found for the given MP . RowCount ::" &RwcnTrans ,"Nope"	
				
		End If

If Err.Number <> 0 Then
		CafeReporter "OTrans_ClickStepType","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
End If
	
	
End Function


'************************************************************************************************************************************************
'Function Name: OTrans_FillStepTypeDetails()
'Function Desc   :Fill the Step Details after clicking on the Transaction that is searched in 'Open transaction' page  
'Arguments: Uses Cafe framework
'Return : Nil
'Example : OTrans_FillStepTypeDetails()
'Author: Supriya
'Created Date :  08-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************

Function OTrans_FillStepTypeDetails()

On error Resume Next 

						'1.0	DATA		
						Table     = GetXML("OPEN_TRANS","TABLE") 'Environment.Value("ScriptID")
						vScriptID = GetXML("OPEN_TRANS","SCRIPT_ID")  'Environment.Value("ScriptID")
						vStep     = GetXML("OPEN_TRANS","STEP") 'Environment.Value("ScriptID")
						
						'1.1 QUERY
						 StrSQL = "Select * from " & Trim(Table) & " where Script_ID = '"& Trim(vScriptID) & "' and Step = '" & Trim(vStep) &"'"
						
						
						'2.0 DATADICTIONARY		
						 GetRecord(StrSQL)
						 
						 
						 
						
						'Details to be filled 
						 vAnnualVolume		 				= Trim(GetRecord_Dict.Item(Ucase("AnnualVolume")))
						 vSecondConsumer		 			= Trim(GetRecord_Dict.Item(Ucase("SecondConsumer")))
						 vSecondConsumerRef		 			= WorkingDay(-2)
						 vFirstConsumerRef		 			= WorkingDay(-2)
						 
						With Browser("Datahub").Page("Open transaction list").Frame("Frame") 
								.Engine("#EXIST--Y")
								.WebEdit("AnnualVolume").Engine(vAnnualVolume)
 								.WebEdit("FirstConsumerReference").Engine(vFirstConsumerRef)
								.WebEdit("SecondConsumerName").Engine(vSecondConsumer)
 								.WebEdit("SecondConsumerReference").Engine(vSecondConsumerRef)
 								.WebElement("SubmitButton").Engine("#CLICK--2")

 								
 						End With 	
 						
 						If not Browser("Datahub").Page("Open transaction list").Frame("Frame").Exist(20)  Then
 							
 							CafeReporter "OTrans_FillStepTypeDetails","OTrans_FillStepTypeDetails","Pass","The Transaction is accepeted" ,"Yes"
 							
 						Else
							CafeReporter "OTrans_FillStepTypeDetails","OTrans_FillStepTypeDetails","Fail","The Transaction is accepeted" ,"Nope" 						
 						End If


If Err.Number <> 0 Then
		CafeReporter "OTrans_FillStepTypeDetails","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
End If

End Function

'************************************************************************************************************************************************
'Function Name: MoveIn_ClickBTDID()
'Function Desc   :Click on the BTD id after logging in. The id has already ben stored in the config file  
'Arguments: Uses Cafe framework
'Return : Nil
'Example : MoveIn_ClickBTDID()
'Author: Supriya
'Created Date :  08-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function MoveIn_ClickBTDID()

On Error Resume Next 

			
 								'DATA
							 	 
								vBTDID						 = GETXML("BTD","BTDID")
								
								
								'SCREEN
								With Browser("Datahub").Page("View metering point")
										.Link("Business transactions").Engine("#CLICK--2") 
															
								End With
								
							
								RowNumbID = Browser("Datahub").Page("View business transactions").WebTable("BusinessTransactionGrid").GetRowWithCellText(vBTDID)
								
								Browser("Datahub").Page("View business transactions").WebTable("BusinessTransactionGrid").ChildItem(RowNumbID,1,"Link",0).Engine("#CLICK--2")
								

 	
 	If Err.Number <> 0 Then
		CafeReporter "MoveIn_ClickBTDID","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
End If
  End Function 

'************************************************************************************************************************************************
'Function Name: MoveIn_VerifyBTDStepCreated()
'Function Desc   :verify the BTD Step after completing the Move in Function  
'Arguments: Uses Cafe framework
'Return : Nil
'Example : MoveIn_VerifyBTDStepCreated()
'Author: Supriya
'Created Date :  08-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function MoveIn_VerifyBTDStepCreated()
	
	On error Resume Next
	wait 10 
			With Browser("Datahub").Page("View business transactions").WebTable("BusinessTransactionStepsGrid")
				.CheckBTDStep "Start of supply Request (RSM-001)","Received","2"
				.CheckBTDStep "Start of supply Approval (RSM-001)","Dequeued|Available","2"
				.CheckBTDStep "Metering point characteristics Notification (RSM-007)","Dequeued|Available","2"
				.CheckBTDStep "Metering point characteristics Information (RSM-007)","Received|Expected","2"
				.CheckBTDStep "Metering point characteristics Approval (implicit)","Implicit|Depending","2"
				.CheckBTDStep "Change of supplier Notification (RSM-004)","Scheduled","2"
				.CheckBTDStep "Metering point characteristics Notification (RSM-007)","Scheduled|Available|Dequeued","9"
 
				
				
			End With
		
		
	
	
	
	If Err.Number <> 0 Then
		CafeReporter "MoveIn_VerifyBTDStepCreated","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If

	
End Function
	
'************************************************************************************************************************************************
'Function Name: CheckBTDStep(Byref obj,Byval vStepType,Byval vStepStatus ,Byval vStartRow)
'Function Desc   :verify the Bsiness Transaction  Step  of a Metering Point 
'Arguments: Uses Cafe framework
'Return : Nil
'Example :   Obj.CheckBTDStep "Metering point characteristics Notification (RSM-007)","Scheduled|Available|Dequeued","9"
 'Author: Supriya
'Created Date :  08-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************ 

Function CheckBTDStep(Byref obj,Byval vStepType,Byval vStepStatus ,Byval vStartRow)

On Error Resume Next 

					'1.0 DATA 
							
							bStatus = false 
							vStepStatus = Split(vStepStatus,"|")	 
						 	vtableName = obj.GetTOProperty("TestObjName")

 
					'2.0  VERIFY BUSINESS TRANSACTION STEP TYPE 
								vGetStepRow = obj.GetRowWithCellText(vStepType,1,vStartRow)'get the Row  umber with the Step required						
								If vGetStepRow > 0  Then 
										 
										CafeReporter "CheckBTDStep","VERIFY BUSINESS TRANSACTION STEP TYPE ","Pass","BTD  Type created  is  as expected.","Yes  :: " & vStepType 
 							     		vActualStepStatus  	=  obj.GetCellData(vGetStepRow,5)
					'3.0  VERIFY BUSINESS TRANSACTION STEP STATUS 	     		
							     		For Iter = 0 To Ubound(vStepStatus)  Step 1
					 
									     		vExpStatus = vStepStatus(Iter)
									     		If Strcomp(Trim(vActualStepStatus),Trim(vExpStatus),1) =  0  Then
									     			bStatus = True
													Exit For 	
									     		End If
							    		Next
							    				'						   						    		
								Else
										CafeReporter "CheckBTDStep","VERIFY BUSINESS TRANSACTION STEP TYPE ","Fail","BTD  STEP  Type created  is  as expected.","Nope. Actual STEP :-'" & vActualStepType &  " and ' Expected Type :-'" & vStepType
 
								End If						 	
'						 	
					
					
							If bStatus  Then
								CafeReporter "CheckBTDStep","VERIFY BUSINESS TRANSACTION STEP STATUS","Pass","BTD STEP  Status created  is  as expected.","Yes  :: " & vActualStepStatus
 
				     		Else
								CafeReporter "CheckBTDStep","VERIFY BUSINESS TRANSACTION STEP STATUS","Fail","BTD STEP  Status  created  is  as expected.","Nope.Actual Status::  " & vActualStepStatus	 & "and Expected Status :: " & vExpStatus					     		
 
				     		End If
	 
If Err.Number <> 0 Then
		CafeReporter "CheckBTDStep","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If
End Function
'************************************************************************************************************************************************
'Function Name: MoveIn_CompareStatesResults()
'Function Desc   :Compares the 2 States craeted after completing the Move-in functionality
'Arguments: Uses Cafe framework
'Return : Nil
'Example :   MoveIn_CompareStatesResults()
 'Author: Supriya
'Created Date :  08-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************ 
Function MoveIn_CompareStatesResults()
	On Error Resume Next 
		
			With Browser("Datahub").Page("View meteringpoint history").WbfGrid("CompareResults")
			
				.ChkComparedStatesResults "First consumer party reference","DIFF"
				.ChkComparedStatesResults "Second consumer party name","DIFF"
				.ChkComparedStatesResults "Second consumer party reference","DIFF"
				.ChkComparedStatesResults "Estimated annual volume","DIFF"
			End With
	
	
	
	
	
	If Err.Number <> 0 Then
		CafeReporter "MoveIn_CompareStatesResults","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If
End Function
'************************************************************************************************************************************************
'Function Name: DeleteMP_CompareStatesResults()
'Function Desc   :Compare 2 states after Deteing a state in 'History ' Tab of View Metering Point page 
'Arguments: Uses Cafe framework
'Return : Nil
'Example :   DeleteMP_CompareStatesResults()
 'Author: Supriya
'Created Date :  08-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************ 
Function DeleteMP_CompareStatesResults()
	On Error Resume Next 
		
			With Browser("Datahub").Page("View meteringpoint history").WbfGrid("CompareResults")
			
				.ChkComparedStatesResults "Postcode","SIMILAR"
				.ChkComparedStatesResults "City name","SIMILAR"
				.ChkComparedStatesResults "Country name","SIMILAR"
				
			End With
	
	
	
	
	
	If Err.Number <> 0 Then
		CafeReporter "DeleteMP_CompareStatesResults","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	eLSE
		CafeReporter "DeleteMP_CompareStatesResults","DeleteMP_CompareStatesResults","Pass","Deleted State has City name,Postcode and Country name same as the previous State","Yes"
			
	End If
End Function
'************************************************************************************************************************************************
'Function Name: DeleteMP_ExitHistStates()
'Function Desc   :Exit the Historical States Page 
'Arguments: Uses Cafe framework
'Return : Nil
'Example :  DeleteMP_ExitHistStates
 'Author: Supriya
'Created Date :  08-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************ 
Function DeleteMP_ExitHistStates()
	
	On Error Resume Next

		Browser("Datahub").Page("View historical metering").WebElement("Exit").Click

	
	If Err.Number <> 0 Then
		CafeReporter "DeleteMP_ExitHistStates","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If
End Function
'************************************************************************************************************************************************
'Function Name: ChkComparedStatesResults(Byval obj ,Byval RowName,Byval vExpMsg)
'Function Desc   :In the History Tab , Compare the 2 sttses created with either similar or different  expecteed messages 
'Arguments: Uses Cafe framework
'Return : Nil
'Example :   .ChkComparedStatesResults "Country name","SIMILAR"
 'Author: Supriya
'Created Date :  08-08-2014
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************ 
Function ChkComparedStatesResults(Byval obj ,Byval RowName,Byval vExpMsg)
	
	On Error Resume Next 
'						 
						
						'1.0 GET THE ROW NUMBER OF THE DESIRED ROWNAME  TO BE COMPARED
						
							vStateRwcnt = obj.RowCount					
							If vStateRwcnt >  0  Then
								
							
									For Iterator = 2 To vStateRwcnt Step 1
											vCellVal = obj.GetCellData(Iterator,1)
											If Instr(vCellVal,RowName) > 0  Then
												vRowNumb = Iterator
												Exit For 
											End If	
									Next
							 
								   '2.0 COMPARE VALUES FOR THE ROWNUMBER FOUND 
									vExpCellVal1 = obj.GetCellData(vRowNumb,2)
									vExpCellVal2 = obj.GetCellData(vRowNumb,3)
									
									
									Select Case   Ucase(vExpMsg)
									Case "DIFF"
									
										If not Strcomp(Trim(vExpCellVal1),Trim(vExpCellVal2),1)= 0  Then
											CafeReporter "ChkComparedStatesResults","ChkComparedStatesResults","Pass","Values are different as expected for Rowname '" & RowName & "'. The Cell Values are 1." & vExpCellVal1 & " and  2. " & vExpCellVal2,"Yes"
										Else
											CafeReporter "ChkComparedStatesResults","ChkComparedStatesResults","Fail","Values are different as expected for Rowname '" & RowName,"Nope. The Cell Values are :: " & vExpCellVal2 
												
										End If
									
									Case "SIMILAR"
									
										If   Strcomp(Trim(vExpCellVal1),Trim(vExpCellVal2),1)= 0  Then
											CafeReporter "ChkComparedStatesResults","ChkComparedStatesResults","Pass","Values are same as expected for Rowname '" & RowName & "'. The Cell Values are 1." & vExpCellVal1 & " and  2. " & vExpCellVal2,"Yes"
										Else
											CafeReporter "ChkComparedStatesResults","ChkComparedStatesResults","Fail","Values are same as expected for Rowname '" & RowName,"Nope. The Cell Values are :: " & vExpCellVal2 
												
										End If
									
									End Select
							
							End If 
	
	
	
	If Err.Number <> 0 Then
		CafeReporter "ChkComparedStatesResults","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If
	
	
End Function


'************************************************************************************************************************************************
'Function Name: ChgSuppOpenTrns_SubmitTrans()
'Function Desc   :Submit transaction for Change Supplier for a particular MP 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : ChgSuppOpenTrns_SubmitTrans()
'Author: Supriya
'Created Date :  
'Last Edited Date : 29-09-14
'Modification History:
 
'************************************************************************************************************************************************




Function ChgSuppOpenTrns_SubmitTrans()
	
	
	On Error Resume Next
	
					vExpStep 					 = GETXML("OPEN_TRANS","STEP_TYPE")
'					
	
					With Browser("Datahub").Page("Open transaction list").Frame("Frame") 
								.Engine("#EXIST--Y")
								.WebElement("SubmitButton").Engine("#CLICK--2")

 					End With 
 					
 					' Success Message Verification
					vMsg = Browser("Datahub").Page("Open transaction list").WebElement("SuccessMsgLabel").GetROProperty("innertext")				
					vSuccessMsg = GetXML("CREATE_SPLMP","SUCCESS_MSG")
					
					
					If StrComp(vMsg,vSuccessMsg,1) = 0 Then
						CafeReporter "ChgSuppOpenTrns_SubmitTrans","ChgSuppOpenTrns_SubmitTrans","Pass","Successs Message is displayed ::" & vMsg  ,"Yes"					
						Else	
						CafeReporter "ChgSuppOpenTrns_SubmitTrans","ChgSuppOpenTrns_SubmitTrans","Fail","Successs Message is displayed ","Nope"					
					End If
					
					'Click on The Metering Point 
					
					 RwcnTrans = Browser("Datahub").Page("Open transaction list").WbfGrid("ResultGrid").RowCount

					 
		
						For Iterator = 2 To RwcnTrans Step 1
				
								vActStep = Browser("Datahub").Page("Open transaction list").WbfGrid("ResultGrid").GetCellData(Iterator,4)
								
								If Strcomp(trim(vActStep),trim(vExpStep),1) = 0  Then
									
									 Browser("Datahub").Page("Open transaction list").WbfGrid("ResultGrid").ClickCell Iterator,2
									 Exit For
								End If
 						Next
 						
 						wait 20 
 						'Check Buisness Tranasction 
' 						With Browser("Datahub").Page("View metering point")
'								.Link("Business transactions").Engine("#CLICK--2") 
'								
'							End With 
'							
' 						With Browser("Datahub").Page("View business transactions").WebTable("BusinessTransactionGrid")
' 							
'							.CheckBTDType vExpectedBTDType,"Cancelled"
'
'						End With
 						
 						
 	If Err.Number <> 0 Then
		CafeReporter "ChgSuppOpenTrns_SubmitTrans","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	Else
		CafeReporter "ChgSuppOpenTrns_SubmitTrans","ChgSuppOpenTrns_SubmitTrans","Pass","Tranasaction of Change Supplier accepeted","Yes"	
	End If				
End Function




'************************************************************************************************************************************************
'Function Name: CMP_ViewBusinessTransaction(Byval vExpBTDType,Byval vExpBTDStatus)
'Function Desc   :View the  Business Transaction  
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CMP_ViewBusinessTransaction("Create Metering Point","Finished")
'Author: Supriya
'Created Date :  
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************




Function CMP_ViewBusinessTransaction(Byval vExpBTDType,Byval vExpBTDStatus)
On Error Resume Next 

							
					 		bType = false
					
							With Browser("Datahub").Page("View metering point")
									.Link("Business transactions").Engine("#CLICK--2") 
															
							End With 
							
							Set obj =  Browser("Datahub").Page("View business transactions").WebTable("BusinessTransactionGrid")
					
					 							 
 							 
							
							RowCount =  obj.RowCount
							For Iterator = 2  To RowCount   Step 1
								
								'VERIFY BTD TYPE
								vActBTDType = obj.GetCellData(Iterator,4)
								
								If Strcomp(Trim(vActBTDType),Trim(vExpBTDType),1)  =  0  Then
								
										CafeReporter "CMP_ViewBusinessTransaction","Check Business Transaction TYPE","Pass","BTD  Type created  is  as expected.","Yes  :: " & vExpBTDType										
										Obj.ChildItem(Iterator,1,"Link",0).Click
										vBTDID = Obj.GetCellData(Iterator,1)														 
										SETXML  "BTD","BTDID",vBTDID
													
									
						     			'VERIFY BTD STATUS
						     			If  not vExpBTDStatus = "" Then
						     			 	
						     			 	vActualStatus  	=  obj.GetCellData(Iterator,5)
								     		If Strcomp(Trim(vActualStatus),Trim(vExpBTDStatus),1) =  0  Then
								     			 CafeReporter "CMP_ViewBusinessTransaction","Check Business Transaction STATUS","Pass","BTD  Status created  is  as expected.","Yes  :: " & vActualStatus 
									
												Else
												CafeReporter "CMP_ViewBusinessTransaction","Check Business Transaction STATUS","Fail","BTD  Status created  is  as expected.","Nope  :: Actual status :-" & vActualStatus & "Expected Status :-" & vExpBTDStatus 
											 End If
								     		
								     	End If	
								     	bType = True
								     	Exit For 
							 End  If 
							
							
						Next
							
							If not  bType Then		
							
									CafeReporter "CMP_ViewBusinessTransaction","Check Business Transaction TYPE","Fail","BTD  Type created  is  as expected.","Nope.Expecteed BTD Type ::" & vExpBTDType &"Actual::" & vActBTDType
														
							End If							
	If Err.Number <> 0 Then
		CafeReporter "CMP_ViewBusinessTransaction","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	 
End If 
End Function


'************************************************************************************************************************************************
'Function Name: CCalcStr_VerifyAutogenvalues()
'Function Desc   :Verifies the Autogen Values of Group 1 Direct  Claculation Structure template
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CCalcStr_VerifyAutogenvalues()
'Author: Supriya
'Created Date : 28/10/2014 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function CCalcStr_VerifyAutogenvalues()
		On Error Resume Next 
		With Browser("Datahub").Page("Create calculation structure")
		
				strAutoNetProd = .WebEdit("AutogenDirectNetProdMPM1").GetROProperty("default value")							
				strAutoSuppGrid = .WebEdit("AutogenDirectSupplyFromGridM3").GetROProperty("default value")'#SET--@GETXML("ISCALC","M1")
				vAutoNetProd = GETXML("ISCALC","M1")							
				vAutoSuppGrid = GETXML("ISCALC","M3")
				
				If Strcomp(Trim(strAutoNetProd),Trim(vAutoNetProd)) = 0  and Strcomp(Trim(strAutoSuppGrid),Trim( vAutoSuppGrid)) = 0   Then
					CafeReporter "CCalcStr_VerifyAutogenvalues","CCalcStr_VerifyAutogenvalues" ,"Pass","Auto gen Values displayed are as expected" ,"Yes"
				Else			
					CafeReporter "CCalcStr_VerifyAutogenvalues","CCalcStr_VerifyAutogenvalues" ,"Fail","Auto gen Values displayed are as expected","Nope.Expected 'Net production M1' value :: " & vAutoNetProd & "Actual :: " & strAutoNetProd& "Expected 'Consumption Supply Grid M3' value:: " & vAutoSuppGrid & "Actual :: " & strAutoSuppGrid
					
				End If
				
		End With
		
	If Err.Number <> 0 Then
		CafeReporter "CCalcStr_VerifyAutogenvalues","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	 
End If 	
End Function

'************************************************************************************************************************************************
'Function Name: CCalcStr_Group1Install1VerifyAutogenvalues()
'Function Desc   :Verifies the Autogen Values of Group 1 Installation  Claculation Structure template
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CCalcStr_Group1Install1VerifyAutogenvalues()
'Author: Supriya
'Created Date : 28/10/2014 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function CCalcStr_Group1Install1VerifyAutogenvalues()
		On Error Resume Next 
		With Browser("Datahub").Page("Create calculation structure")
		
				strAutoNetProdM1 = .WebEdit("Grp1InstAutogenNetProdMPM1").GetROProperty("default value")							
				strAutoSuppGridM2 = .WebEdit("Grp1InstAutogenSuppToGridM2").GetROProperty("default value")
				strAutoSuppGridM3 = .WebEdit("Grp1InstAutogenSuppFromGridM3").GetROProperty("default value")
				vAutoNetProdM1 = GETXML("ISCALC","M1")							
				vAutoSuppGridM2 = GETXML("ISCALC","M2")
				vAutoSuppGridM3 = GETXML("ISCALC","M3")
				
										
										
				
				If Strcomp(Trim(strAutoNetProdM1),Trim(vAutoNetProdM1)) = 0  and Strcomp(Trim(strAutoSuppGridM2),Trim( vAutoSuppGridM2)) = 0 and Strcomp(Trim(strAutoSuppGridM3),Trim( vAutoSuppGridM3)) = 0    Then
					CafeReporter "CCalcStr_Group1Install1VerifyAutogenvalues","CCalcStr_Group1Install1VerifyAutogenvalues" ,"Pass","Auto gen Values displayed are as expected" ,"Yes"
				Else			
					CafeReporter "CCalcStr_Group1Install1VerifyAutogenvalues","CCalcStr_Group1Install1VerifyAutogenvalues" ,"Fail","Auto gen Values displayed are as expected","Nope.Expected 'Net production M1' value :: " & vAutoNetProdM1 & "Actual :: " & strAutoNetProdM1 & "Expected 'Consumption Supply Grid M3' value:: " & vAutoSuppGridM3& "Actual :: " & strAutoSuppGridM3 & "Expected 'Consumption Supply Grid M2' value:: " & vAutoSuppGridM2 & "Actual :: " & strAutoSuppGridM2
					
				End If
				
		End With
		
	If Err.Number <> 0 Then
		CafeReporter "CCalcStr_Group1Install1VerifyAutogenvalues","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	 
End If 	
End Function

'************************************************************************************************************************************************
'Function Name: CCalcStr_Group2InstallVerifyAutogenvalues()
'Function Desc   :Verifies the Autogen Values of Group 2 Installation  Claculation Structure template
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CCalcStr_Group2InstallVerifyAutogenvalues()
'Author: Supriya
'Created Date : 28/10/2014 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function CCalcStr_Group2InstallVerifyAutogenvalues()
		On Error Resume Next 
		With Browser("Datahub").Page("Create calculation structure")
		
				 							
				strAutoSuppGridM2 =  .WebEdit("Grp2InstAutogenSupplyToGridM2").GetROProperty("default value")
				strAutoSuppGridM3 =   .WebEdit("Grp2InstAutogenSupplyFromGridM3").GetROProperty("default value")
				
				
				vAutoSuppGridM2 = GETXML("ISCALC","M2")
				vAutoSuppGridM3 = GETXML("ISCALC","M3")
				
										
										
				
				If Strcomp(Trim(strAutoSuppGridM3),Trim(vAutoSuppGridM3)) = 0  and Strcomp(Trim(strAutoSuppGridM2),Trim( vAutoSuppGridM2)) = 0    Then
					CafeReporter "CCalcStr_Group2InstallVerifyAutogenvalues","CCalcStr_Group2InstallVerifyAutogenvalues" ,"Pass","Auto gen Values autofilled are as expected" ,"Yes"
				Else			
					CafeReporter "CCalcStr_Group2InstallVerifyAutogenvalues","CCalcStr_Group2InstallVerifyAutogenvalues" ,"Fail","Auto gen Values autofilled are as expected","Nope.Expected 'Consumption Supply Grid M2' value :: " & vAutoSuppGridM2& "Actual :: " & strAutoSuppGridM2& "Expected 'Consumption Supply  Grid M3' value:: " & vAutoSuppGridM3 & "Actual :: " & strAutoSuppGridM3
					
				End If
				
		End With
		
	If Err.Number <> 0 Then
		CafeReporter "CCalcStr_Group2InstallVerifyAutogenvalues","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	 
End If 	
End Function
'************************************************************************************************************************************************
'Function Name: CCalcStr_Group2DirectVerifyAutogenvalues()
'Function Desc   :Verifies the Autogen Values of Group 2 Direct  Claculation Structure template
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CCalcStr_Group2DirectVerifyAutogenvalues()
'Author: Supriya
'Created Date : 28/10/2014 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function CCalcStr_Group2DirectVerifyAutogenvalues()
		On Error Resume Next 
		With Browser("Datahub").Page("Create calculation structure")
		
				 							
				strNetProdM1 	  =  .WebEdit("AutogenDirectNetProdMPM1").GetROProperty("default value")
				strAutoSuppGridM3 =   .WebEdit("Grp2InstAutogenSupplyToGridM2").GetROProperty("default value")
				
				
				vNetProdM1 		= GETXML("ISCALC","M1")
				vAutoSuppGridM3 = GETXML("ISCALC","M3")
				
										
										
				
				If Strcomp(Trim(strNetProdM1),Trim(vNetProdM1)) = 0  and Strcomp(Trim(strAutoSuppGridM3),Trim( vAutoSuppGridM3)) = 0    Then
					CafeReporter "CCalcStr_Group2DirectVerifyAutogenvalues","CCalcStr_Group2DirectVerifyAutogenvalues" ,"Pass","Auto gen Values autofilled are as expected" ,"Yes"
				Else			
					CafeReporter "CCalcStr_Group2DirectVerifyAutogenvalues","CCalcStr_Group2DirectVerifyAutogenvalues" ,"Fail","Auto gen Values autofilled are as expected","Nope.Expected 'Net production M1' value :: " & vNetProdM1& "Actual :: " & strNetProdM1 & "Expected 'Consumption Supply Grid M3' value:: " & vAutoSuppGridM3 & "Actual :: " & strAutoSuppGridM3
					
				End If
				
		End With
		
	If Err.Number <> 0 Then
		CafeReporter "CCalcStr_Group2DirectVerifyAutogenvalues","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	 
End If 	
End Function
'************************************************************************************************************************************************
'Function Name: CCalcStr_Group2InstallVerifyConsumptionvalues()
'Function Desc   :Verifies the Consumption Values of Group 2 Installation  Claculation Structure template
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CCalcStr_Group1Install2VerifyConsumptionvalues()
'Author: Supriya
'Created Date : 28/10/2014 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function CCalcStr_Group2InstallVerifyConsumptionvalues()
		On Error Resume Next 
		With Browser("Datahub").Page("Create calculation structure")
		
				 							
				strAutoSuppGridM2 =  .WebEdit("Grp2InsConsumptionSupplyToGridM2").GetROProperty("default value")
				strAutoSuppGridM3 =   .WebEdit("Grp2InsConsumptionSupplyFromGridM3").GetROProperty("default value")
				
				
				vAutoSuppGridM2 = GETXML("ISCALC","M2")
				vAutoSuppGridM3 = GETXML("ISCALC","M3")
				
										
										
				
				If Strcomp(Trim(strAutoSuppGridM3),Trim(vAutoSuppGridM3)) = 0  and Strcomp(Trim(strAutoSuppGridM2),Trim( vAutoSuppGridM2)) = 0    Then
					CafeReporter "CCalcStr_Group1Install2VerifyConsumptionvalues","CCalcStr_Group1Install2VerifyConsumptionvalues" ,"Pass","Consumption Values autofilled  are as expected" ,"Yes"
				Else			
					CafeReporter "CCalcStr_Group1Install2VerifyConsumptionvalues","CCalcStr_Group1Install2VerifyConsumptionvalues" ,"Fail","Consumption Values autofilled  are as expected","Nope.Expected 'Consumption Supply Grid M2' value :: " & vAutoSuppGridM2& "Actual :: " & strAutoSuppGridM2& "Expected 'Consumption Supply  Grid M3' value:: " & vAutoSuppGridM3 & "Actual :: " & strAutoSuppGridM3
					
				End If
				
		End With
		
	If Err.Number <> 0 Then
		CafeReporter "CCalcStr_Group1Install2VerifyConsumptionvalues","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	 
End If 	
End Function
'************************************************************************************************************************************************
'Function Name: CCalcStr_Group2DirectVerifyConsumptionvalues()
'Function Desc   :Verifies the Consumption Values of Group 2 Direct  Claculation Structure template
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CCalcStr_Group2DirectVerifyConsumptionvalues()
'Author: Supriya
'Created Date : 28/10/2014 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function CCalcStr_Group2DirectVerifyConsumptionvalues()
		On Error Resume Next 
		With Browser("Datahub").Page("Create calculation structure")
		
				 							
				strNetProdM1 	  =  .WebEdit("ConsumptionNetProdM1").GetROProperty("default value")
				strAutoSuppGridM3 =   .WebEdit("Grp2InsConsumptionSupplyFromGridM3").GetROProperty("default value")
				
				
				vNetProdM1 		= GETXML("ISCALC","M1")
				vAutoSuppGridM3 = GETXML("ISCALC","M3")
				
										
										
				
				If Strcomp(Trim(strNetProdM1),Trim(vNetProdM1)) = 0  and Strcomp(Trim(strAutoSuppGridM3),Trim( vAutoSuppGridM3)) = 0    Then
					CafeReporter "CCalcStr_Group2DirectVerifyConsumptionvalues","CCalcStr_Group2DirectVerifyConsumptionvalues" ,"Pass","Auto gen Values autofilled are as expected" ,"Yes"
				Else			
					CafeReporter "CCalcStr_Group2DirectVerifyConsumptionvalues","CCalcStr_Group2DirectVerifyConsumptionvalues" ,"Fail","Auto gen Values autofilled are as expected","Nope.Expected 'Net Production M1' value :: " & vNetProdM1 & "Actual :: " & strNetProdM1 & "Expected 'Consumption Supply  Grid M3' value:: " & vAutoSuppGridM3 & "Actual :: " & strAutoSuppGridM3
					
				End If
				
		End With
		
	If Err.Number <> 0 Then
		CafeReporter "CCalcStr_Group2DirectVerifyConsumptionvalues","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	 
End If 	
End Function


'************************************************************************************************************************************************
'Function Name: CCalcStr_Grp2PSOExeVerifyConsValues()
'Function Desc   :Verifies the Consumption Values of Group 2 PSO Exempt  Claculation Structure template
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CCalcStr_Grp2PSOExeVerifyConsValues()
'Author: Supriya
'Created Date : 28/10/2014 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************
Function CCalcStr_Grp2PSOExeVerifyConsValues()
		On Error Resume Next 
		With Browser("Datahub").Page("Create calculation structure")
		
				 							
				strConsSuppToGridM2 	  =  .WebEdit("Grp2InsConsumptionSupplyToGridM2").GetROProperty("default value")
				strConsSuppFrmGridM3	  =   .WebEdit("Grp2InsConsumptionSupplyFromGridM3").GetROProperty("default value")
				
				
				vConsSuppToGridM2 		= GETXML("ISCALC","M2")
				vConsSuppFrmGridM3 		= GETXML("ISCALC","M3")
				
										
										
				
				If Strcomp(Trim(strConsSuppToGridM2),Trim(vConsSuppToGridM2)) = 0  and Strcomp(Trim(strConsSuppFrmGridM3),Trim( vConsSuppFrmGridM3)) = 0    Then
					CafeReporter "CCalcStr_Grp2PSOExeVerifyConsValues","CCalcStr_Grp2PSOExeVerifyConsValues" ,"Pass","Auto gen Values autofilled are as expected" ,"Yes"
				Else			
					CafeReporter "CCalcStr_Grp2PSOExeVerifyConsValues","CCalcStr_Grp2PSOExeVerifyConsValues" ,"Fail","Auto gen Values autofilled are as expected","Nope.Expected 'Consumption Supply To Grid' value :: " & vConsSuppToGridM2 & "Actual :: " & strConsSuppToGridM2 & "Expected 'Consumption Supply From Grid' value:: " & vConsSuppFrmGridM3 & "Actual :: " & strConsSuppFrmGridM3
 					
				End If
				
		End With
		
	If Err.Number <> 0 Then
		CafeReporter "CCalcStr_Grp2PSOExeVerifyConsValues","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	 
End If 	
End Function




'************************************************************************************************************************************************
'Function Name: CCalcStr_VerifyGSRN(ByVal vNetSettlement)
'Function Desc   :Verifies if the GSRN and netsettlement values present are correct in the Calculation structure templ ate
'Arguments: Uses Cafe framework
'Return : Nil
'Example : CCalcStr_VerifyGSRN("Group-1 Direct")
'Author: Supriya
'Created Date : 21/10/2014 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************

Function CCalcStr_VerifyGSRN(ByVal vNetSettlement)

On Error Resume Next 
		'Success Message Verification
			vMPR1 = GETXML("ISCALC","R1")				
			strGSRN =  Browser("Datahub").Page("View calculation structure").WebTable("GSRN").GetCellData(1,1)
			
			If Instr(Trim(strGSRN),Trim(vMPR1),1)  > 0  Then
				CafeReporter "CCalcStr_VerifyGSRN","CCalcStr_VerifyGSRN" ,"Pass","GSRN is the id of R1 value as expected " ,"Yes"
				Else			
				CafeReporter "CCalcStr_VerifyGSRN","CCalcStr_VerifyGSRN" ,"Nope","GSRN is the id of R1 value as expected ","Nope.Expected GSRN Value :: " & vMPR1 & "Actual Value :: " & strGSRN	
			End If
			If Instr(Trim(strGSRN),Trim(vNetSettlement),1)  > 0  Then
				CafeReporter "CCalcStr_VerifyGSRN","CCalcStr_VerifyNetSettlement" ,"Pass","Expected NetSettlement  is present in the 'View Claculation Structure Template' Page " ,"Yes"
				Else			
				CafeReporter "CCalcStr_VerifyGSRN","CCalcStr_VerifyNetSettlement" ,"Nope","Expected NetSettlement  is present in the View Claculation Structure Template ","Nope.Expected NetSettlement Value :: " & vNetSettlement & "Actual Value :: " & strGSRN	
			End If
			
			
 If Err.Number <> 0 Then
		CafeReporter "CCalcStr_VerifyGSRN","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
	End If 				
						
End Function

'************************************************************************************************************************************************
'Function Name: MonitorMPViewMD_ValidateTimeSeries(ByVal Val,ByVal Quan_Qual)
'Function Desc   :Validates the Time Series for a Metering point  
'Arguments: Uses Cafe framework
'Return : Nil
'Example : MonitoCalc_VerifyResult()
'Author: Supriya
'Created Date : 23/10/2014 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************


Function MonitorMPViewMD_ValidateTimeSeries(ByVal Val,ByVal Quan_Qual)

			On Error Resume Next 
	 	 
					Err_Cmp = False 'Flag for Error

	 	 			Dt = GetDt_XML("ISCALC::EFF_DT_SPLMP")		'Get the Period Date
					Dt_chgFormat = Split(dt,"/")
'					Dt_YYYYMMDD = Trim(Dt_chgFormat(2)) &"-"& Trim(Dt_chgFormat(1)) &"-"& Trim(Dt_chgFormat(0))		'converting the date format from DD/MM/YYYY to YYYY-MM-DD
	 	 
					Hour_Array = Split(GetXML("ISCALC","Hour_Reading"),",")
	
					Browser("Datahub").Page("Monitor time series").WbfGrid("ResultGrid").ClickCell 2,7
					With Browser("Datahub").Page("Monitor time series").Frame("Frame").WbfGrid("ViewSeriesResultGrid")
					
								.Exist(15) 'Sync								
								rcount = .RowCount		'This method adds the row of header and table border to the count by default. So the actual row count of record is "rcount -2"
								
								
								If rcount-2 <> Ubound(Hour_Array)+1 Then		'Validate whether the row counts reflect 24 hours enteries.	
									CafeReporter "MonitorMPViewMD_ValidateTimeSeries","Monito Mp - TimeSeries","Fail","Expected 24 Rows of time series enteries","Actual '" & Trim(rcount) &"' rows of time series are displayed."
								End If	
								RowVal = Browser("Datahub").Page("Monitor time series").Frame("Frame").WebTable("Metering point").GetCellData(4,2)
											If Strcomp(Trim(RowVal),"Time Series processed without errors",1) = 0  Then
												CafeReporter "MonitorMPViewMD_ValidateTimeSeries","MonitorMPViewMD_ValidateTimeSeries" ,"Pass","Status is as expected " ,"Yes"
											Else
												CafeReporter "MonitorMPViewMD_ValidateTimeSeries","MonitorMPViewMD_ValidateTimeSeries" ,"Fail","Status is as expected ","Nope.Expecteed Status :: Time Series processed without errors. Actual Status :: " & RowVal										
											End If
																			
								
								
								For i = 0 To Ubound(Hour_Array)					
										Ex_period  		= replace(Dt,"-","/") &" "& Trim(Hour_Array(i))				'Expected Values
										Ex_Val	   		= Cdbl(Replace(Trim(Val),".",","))
										Ex_Quan_Qual	= Trim(Quan_Qual)									
																											'Actual Values	
										period 		= Trim(.GetCellData(i+2,1))
										AcVal    	= Cdbl(Replace(Trim(.GetCellData(i+2,2)),".",","))	'To Support Danish Numbering system since OS language is Dansk. Moreover using Double since the value is returned with 3 decimal points.
										Quan_Qlty 	= Trim(.GetCellData(i+2,4))
										
		
										If StrComp(Ex_period,period,0) <> 0 OR Eval(Ex_Val=AcVal) <> True OR Strcomp(Ex_Quan_Qual,Quan_Qlty,1) <> 0  Then																						
											CafeReporter "MonitorMPViewMD_ValidateTimeSeries","MonitorMP - TimeSeries","Fail","Expected Period: " & Ex_period &", Value: '"& Ex_Val &"', Quantity_Quality: '" & Ex_Quan_Qual &"'","Actual Period: " & period &", Value: '"& AcVal &"', Quantity_Quality: '" & Quan_Qlty &"'"												
											Err_Cmp = True 
										End If
								Next
										If Err_Cmp = False Then											
											CafeReporter "MonitorMPViewMD_ValidateTimeSeries","MonitorMP - TimeSeries","Pass","Expected 24 rows of time series enteries with Value: "& Ex_Val &", Quantity_Quality:" & Ex_Quan_Qual,"As expected displayed." 
										End If
								
					End With
					
					Browser("Datahub").Page("Monitor time series").Image("Close").Click
		
			If Err.Number <> 0 Then
					CafeReporter "MonitorMPViewMD_ValidateTimeSeries","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
			End If		
	
	End Function

'************************************************************************************************************************************************
'Function Name: MonitoCalc_VerifyResult()
'Function Desc   :Verifies the Calculation  result for Monitor Time Series found . 
'Arguments: Uses Cafe framework
'Return : Nil
'Example : MonitoCalc_VerifyResult()
'Author: Supriya
'Created Date : 23/10/2014 
'Last Edited Date : 
'Modification History:
 
'************************************************************************************************************************************************

Function MonitoCalc_VerifyResult(vStatus,vErrorType)

On Error Resume Next 
		strStatus 		= Browser("Datahub").Page("Monitor calculations").WbfGrid("ResultGrid").GetCellData(2,6)
		strErrorType	= Browser("Datahub").Page("Monitor calculations").WbfGrid("ResultGrid").GetCellData(2,7)
		
		If StrComp(Trim(strStatus),vStatus,1) = 0 and  StrComp(Trim(strErrorType),vErrorType,1) = 0 Then																						
			CafeReporter "MonitoCalc_VerifyResult","MonitoCalc_VerifyResult","Pass","Status and ErrorType is as expected","Yes"
		Else
			CafeReporter "MonitoCalc_VerifyResult","MonitoCalc_VerifyResult","Fail","Expected Status: " & vStatus &", Expected ErrorType: '"& vErrorType  & "Actual Status: " & strStatus &", ErrorType: '"& strErrorType,"Nope"
		End If

	
	If Err.Number <> 0 Then
					CafeReporter "MonitoCalc_VerifyResult","Error Number = " & Err.number & ", Error Description = " & Err.Description & ".","Fail","",""								
			End If
End Function