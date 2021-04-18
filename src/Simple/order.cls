Class Simple.Order Extends %Persistent
{

Property Number As %String;

Property Value As %Integer;

Property Date As %Date;

Property Customer As Simple.Customer;

Property Saler As Simple.Saler;

Property Gun As Simple.Gun;

/// Create new Order profile<br>
/// <var>Number</var> - Order's Number<br>
/// <var>Value</var> - Order's Value<br>
/// <var>Car</var> - car assigned to the Order on tour<br> 
/// <var>Tour</var> - tour in which the Order takes part<br>
ClassMethod create(Number As %String = "", Value As %Integer = 0, CustomerId As %String = "", SalerId As %String = "", GunId As %String = "", Date As %Date) As Simple.Order
{
    set Order = ..%New()
    set Order.Number = Number
    set Order.Value = Value
    set Order.Date = $ZDateh(Date, 3)
    do Order.CustomerSetObjectId(CustomerId)
    do Order.SalerSetObjectId(SalerId)
    do Order.GunSetObjectId(GunId)
    set st = Order.%Save()
    return Order
}

/// Add request object to table
/// <var>reqObj</var> - request object
ClassMethod add(reqObj) As %DynamicArray
{
  set result = {}
  set obj = ..%New()
  set obj.Number = reqObj.Get("Number")
  set obj.Value = reqObj.Get("Value")
  set obj.Date = $ZDateh(reqObj.Get("date"), 3)
  do obj.CustomerSetObjectId(reqObj.Get("CustomerId"))
  do obj.SalerSetObjectId(reqObj.Get("SalerId"))
  do obj.GunSetObjectId(reqObj.Get("GunId"))
  set saveResult = obj.%Save()

  if $$$ISOK(saveResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessValue = ##class(%SYSTEM.Status).GetErrorText(saveResult)
  set result.messValue = ErrorMessValue

  return result.%ToJSON()
}

/// Get all Orders array (json) from table
ClassMethod getAll() As %DynamicArray
{
    set Orders = []
    set data = ##class(%SQL.Statement).%ExecDirect(, "SELECT * FROM Simple.Order")
    while data.%Next() {
        set obj = {
            "id": (data.ID),
            "Number": (data.Number),
            "Value": (data.Value),
            "date": ($ZDate(data.Date, 3)),
            "CustomerId": (data.Car),
            "GunId": (data.Gun),
            "SalerId": (data.Tour)
        }
        do Orders.%Push(obj)
    }
    return Orders.%ToJSON()
}

/// Get Orders Values list for select editor
ClassMethod getNumberSelectList() As %DynamicArray
{
    set list = []
    set data = ##class(%SQL.Statement).%ExecDirect(, "SELECT * FROM Simple.Order")
    while data.%Next() {
        set obj = {
            "id": (data.ID),
            "value": (data.Number)
        }
        do list.%Push(obj)
    }
    return list.%ToJSON()
}

/// Edit Order's profile
/// <var>reqObj</var> - request obj
ClassMethod edit(reqObj) As %DynamicArray
{
    set Id = reqObj.Get("id")
    set Order = ..%OpenId(Id)
    set result = {}

    if $IsObject(Order) {
        set Order.Number = reqObj.Get("Number")
        set Order.Value = reqObj.Get("Value")
        set Order.Date = $ZDateh(reqObj.Get("date"), 3)
        do Order.CustomerSetObjectId(reqObj.Get("CustomerId"))
        do Order.SalerSetObjectId(reqObj.Get("SalerId"))
        do Order.GunSetObjectId(reqObj.Get("GunId"))
        set saveResult = Order.%Save()
    
        if $$$ISOK(saveResult) set result = {"result": true}
        else  set result = {"result": false}
        set ErrorMessValue = ##class(%SYSTEM.Status).GetErrorText(saveResult)
        set result.messValue = ErrorMessValue
    } else {
        set result = {"result": false}
        set result.messValue = "Invalid Object"
    }


    return result.%ToJSON()
}

/// Delete Order from table by id
/// <var>Id</var> - Order id in the table
ClassMethod delete(Id As %String = "") As %DynamicArray
{
    set deleteResult = ..%DeleteId(Id)
    set result = {}
    if $$$ISOK(deleteResult) set result = {"result": true}
    else  set result = {"result": false}
    set ErrorMessValue = ##class(%SYSTEM.Status).GetErrorText(deleteResult)
    set result.messValue = ErrorMessValue
    return result.%ToJSON()
}

Storage Default
{
<Data name="OrderDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Number</Value>
</Value>
<Value name="3">
<Value>Value</Value>
</Value>
<Value name="4">
<Value>Date</Value>
</Value>
<Value name="5">
<Value>Customer</Value>
</Value>
<Value name="6">
<Value>Saler</Value>
</Value>
<Value name="7">
<Value>Gun</Value>
</Value>
</Data>
<DataLocation>^Simple.OrderD</DataLocation>
<DefaultData>OrderDefaultData</DefaultData>
<IdLocation>^Simple.OrderD</IdLocation>
<IndexLocation>^Simple.OrderI</IndexLocation>
<StreamLocation>^Simple.OrderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
