Class Simple.Customer Extends %Persistent
{

/// Race Customer name
Property Name As %String;

/// Race Customer License 
Property License As %String;

/// Customer Phone 
Property Phone As %String;

/// Create Customer<br>
/// <var>Name</var> - race Customer name<br>
/// <var>License</var> - race Customer License<br>
ClassMethod create(CustomerName As %String, License As %String, Phone As %String) As Simple.Customer
{
    set Customer = ..%New()
    set Customer.Name = CustomerName
    set Customer.License = License
    set Customer.Phone = Phone
    set st = Customer.%Save()
    return Customer
}

/// Save request object to table
/// <var>reqObj</var> - request object
ClassMethod add(reqObj) As %DynamicArray
{
  set result = {}
  set obj = ..%New()
  set obj.Name = reqObj.Get("name")
  set obj.License = reqObj.Get("License")
  set obj.Phone = reqObj.Get("Phone")
  set saveResult = obj.%Save()

  if $$$ISOK(saveResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
  set result.message = ErrorMessage

  return result.%ToJSON()
}

/// Get all Customer array from table
ClassMethod getAll() As %DynamicArray
{
    set Customers = []
    set data = ##class(%SQL.Statement).%ExecDirect(, "SELECT * FROM Simple.Customer")
    while data.%Next() {
        set obj = {
            "id": (data.ID),
            "name": (data.Name),
            "License": (data.License),
            "Phone": (data.Phone)
        }
        do Customers.%Push(obj)
    }
    return Customers.%ToJSON()
}

/// Get Customer name list for select editor
ClassMethod getNameSelectList() As %DynamicArray
{
    set list = []
    set data = ##class(%SQL.Statement).%ExecDirect(, "SELECT * FROM Simple.Customer")
    while data.%Next() {
        set obj = {
            "id": (data.ID),
            "value": (data.Name)
        }
        do list.%Push(obj)
    }
    return list.%ToJSON()
}

/// Edit Customer
/// <var>reqObj</var> - request obj
ClassMethod edit(reqObj) As %DynamicArray
{
    set Id = reqObj.Get("id")
    set Customer = ..%OpenId(Id)
    set result = {}

    if $IsObject(Customer) {
        set Customer.Name = reqObj.Get("name")
        set Customer.License = reqObj.Get("License")
        set Customer.Phone = reqObj.Get("Phone")
        set saveResult = Customer.%Save()
    
        if $$$ISOK(saveResult) set result = {"result": true}
        else  set result = {"result": false}
        set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
        set result.message = ErrorMessage
    } else {
        set result = {"result": false}
        set result.message = "Invalid object"
    }


    return result.%ToJSON()
}

/// Delete Customer from table by id
/// <var>Id</var> - Customer id in the table
ClassMethod delete(Id As %String = "") As %DynamicArray
{
    set deleteResult = ..%DeleteId(Id)
    set result = {}
    if $$$ISOK(deleteResult) set result = {"result": true}
    else  set result = {"result": false}
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(deleteResult)
    set result.message = ErrorMessage
    return result.%ToJSON()
}

Storage Default
{
<Data name="CustomerDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>License</Value>
</Value>
<Value name="4">
<Value>Phone</Value>
</Value>
</Data>
<DataLocation>^Simple.CustomerD</DataLocation>
<DefaultData>CustomerDefaultData</DefaultData>
<IdLocation>^Simple.CustomerD</IdLocation>
<IndexLocation>^Simple.CustomerI</IndexLocation>
<StreamLocation>^Simple.CustomerS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
