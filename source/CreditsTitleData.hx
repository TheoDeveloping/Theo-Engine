package;

using StringTools;

class CreditsTitleData
{
	public var titleArray:String = "";
    public var titleNum:Int;

	public function new(title:String, titleNum:Int)
	{
		this.titleArray = title;
        this.titleNum = titleNum;
	}
}