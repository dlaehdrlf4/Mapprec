
import UIKit

//위치정보 사용을 위한 프레임워크
import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate{

    //위치정보 사용을 위한 인스턴스를 생성
    var locationManager = CLLocationManager()
    //시작위치를 저장할 변수
    var startLocation:CLLocation!
    
    
    @IBOutlet weak var lblLongitude: UILabel!
    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet weak var lblAltitude: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    
    var flag = true
    @IBAction func locationUpdate(_ sender: Any) {
        if flag == true{
            flag = false
        }else{
            flag = true
        }
        //버튼의 타이틀을 가지고 토글
        let btn = sender as! UIButton
        if btn.title(for: .normal) == "위치정보수집시작"{
            //위치정보 수집시작
            locationManager.startUpdatingLocation()
            //위치정보 자동으로 업데이트되고 추가되는것을 추가해준것
            locationManager.pausesLocationUpdatesAutomatically = true
            btn.setTitle("위치정보수집중지", for: .normal)
        }else{
              locationManager.stopUpdatingLocation()
            btn.setTitle("위치정보수집시작", for: .normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //정밀도 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //delegate 설정
        locationManager.delegate = self
        //위치정보 사용 동의 대화상자 출력 - 실행중에만 사용 always는 항상이다.
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    //Mark 위치정보 갱신과 관련된 메소드
    // 위치정보를 가져오는데 성공했을 때 호출되는 메소드
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        //배열에서 위치정보객체 1개 가져오기 // 맨마지막꺼 하나 가져온거다.
        var lastLocation = locations[locations.count-1]
        // 위도 출력
        lblLatitude.text = "\(lastLocation.coordinate.latitude)"
          lblLongitude.text = "\(lastLocation.coordinate.longitude)"
          lblAltitude.text = "\(lastLocation.altitude)"
        
        //시작위치 설정
        if startLocation == nil{
            startLocation = lastLocation
        }
        
        //거리계산 // 현재위치와 출발점의 거리를 계산해준다.
        let distance = lastLocation.distance(from: startLocation)
        lblDistance.text = "\(distance)"
        
    }
    
    
}

