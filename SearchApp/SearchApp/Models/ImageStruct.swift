import Foundation
import UIKit

struct ImageStruct {
    var nameOfImage:String
    var urlOfImage:String
}

extension ImageStruct {
    static var pictures = [
        ImageStruct(nameOfImage: "0", urlOfImage: "http://kakoy-smysl.ru/wp-content/uploads/2020/02/grus-kart-so-sm-1.jpg"),
        ImageStruct(nameOfImage: "1", urlOfImage: "https://wonder-day.com/wp-content/uploads/2020/04/wonder-day-images-rainbow-37-1024x576.jpg"),
        ImageStruct(nameOfImage: "11", urlOfImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRP5VKFOTn-2IxmSp9pcNC_B0PHDDvNQSAeVQ&usqp=CAU"),
        ImageStruct(nameOfImage: "12", urlOfImage: "https://i.pinimg.com/originals/b9/59/f1/b959f1670d2631589643575de5a782b7.jpg"),
        ImageStruct(nameOfImage: "13", urlOfImage: "https://i.pinimg.com/originals/1f/32/de/1f32de75ae0a1ac218a902f6f361a6d7.jpg"),
        ImageStruct(nameOfImage: "14", urlOfImage: "https://sib.fm/storage/article/December2021/kartinki-s-novym-godom-2022-12.jpg"),
        ImageStruct(nameOfImage: "111", urlOfImage: "https://rozabox.com/wp-content/uploads/2019/01/man-5846064_1920-735x400.jpg"),
        ImageStruct(nameOfImage: "119", urlOfImage: "https://lifeandjoy.ru/uploads/posts/2013-11/1384939018_2anita_foto.jpg"),
        ImageStruct(nameOfImage: "222", urlOfImage: "https://i.pinimg.com/564x/e9/ff/ab/e9ffab0b910ac5f3e4898dc1c31038ed.jpg"),
        ImageStruct(nameOfImage: "3", urlOfImage: "https://img3.akspic.ru/previews/6/8/8/1/4/141886/141886-devuska-graficeskij_dizajn-anime-prohlada-illustracia-x750.jpg"),
        ImageStruct(nameOfImage: "32", urlOfImage: "https://img2.akspic.ru/previews/5/5/7/5/1/115755/115755-chernyy-rot-video_prohozhdenie_igry-iskusstvo-prohlada-x750.jpg"),
        ImageStruct(nameOfImage: "33", urlOfImage: "https://img1.akspic.ru/previews/9/7/2/6/4/146279/146279-les-solnechnyj_svet-devuska-drevesina-palec-x750.jpg"),
        ImageStruct(nameOfImage: "34", urlOfImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRw0bKdO-bL6_C7ykX1QMCiEa2xWAIn6I2Y0g&usqp=CAU"),
        ImageStruct(nameOfImage: "35", urlOfImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL5_YZv_1qlNWw87e6g56OTw9R5C2sYm9ERg&usqp=CAU"),
        ImageStruct(nameOfImage: "42", urlOfImage: "https://lifehacker.ru/wp-content/uploads/2020/01/1119-white-flower-2_1579261223.jpg"),
        ImageStruct(nameOfImage: "44", urlOfImage: "https://www.ejin.ru/wp-content/uploads/2017/09/1-931.jpg"),
        ImageStruct(nameOfImage: "55", urlOfImage: "https://aminosart.ru/wp-content/uploads/2021/08/Skachat-krasivye-anime-kartinki-na-avu_53.jpg"),
        ImageStruct(nameOfImage: "66", urlOfImage: "https://anime-fans.ru/wp-content/uploads/2021/04/Krasivye-anime-kartinki-na-avu-dlya-devushek_03.jpg"),
        ImageStruct(nameOfImage: "77", urlOfImage: "http://img0.liveinternet.ru/images/attach/b/3/28/580/28580809_59065.jpg"),
        ImageStruct(nameOfImage: "88", urlOfImage: "https://pictureholiday.ru/wp-content/uploads/2018/05/e77d3da8e42f0eb.jpg"),
        ImageStruct(nameOfImage: "89", urlOfImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBRIarK6snduuLgHLVPHQGk57Mp9jCIJBCciFIOz3jb-ow_WhN5MCL4yEAPQ7gJ85TxZQ&usqp=CAU"),
        ImageStruct(nameOfImage: "91", urlOfImage: "https://proprikol.ru/wp-content/uploads/2019/08/krutye-kartinki-dlya-vk-3.jpg"),
        ImageStruct(nameOfImage: "92", urlOfImage: "https://moydrygpk.ru/wp-content/uploads/2017/10/kartinka-na-kartinku-7.jpg"),
        ImageStruct(nameOfImage: "93", urlOfImage: "https://tattooinfo.ru/wp-content/uploads/voyucshij-volk-kartinka_13.jpg"),
        ImageStruct(nameOfImage: "94", urlOfImage: "https://mybestbark.com/wp-content/uploads/2020/09/Shiba-Akita-Mix-Incredible-Energy-Unmatched-Loyalty.jpg"),
        ImageStruct(nameOfImage: "95", urlOfImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYNDIQmWK3w1e8TBrcCC9eCpTMmHr_oZEbzV5kfIfUcMVBm1ders_jvaSQ-jVZ7w_IiVs&usqp=CAU"),
        ImageStruct(nameOfImage: "96", urlOfImage: "https://content.fun-japan.jp/renewal-prod/cms/articles/content/shutterstock1481706194jpg_2021-03-03-03-15-17.jpg"),
        ImageStruct(nameOfImage: "97", urlOfImage: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/78/Akita_inu.jpeg/800px-Akita_inu.jpeg?20060716004640"),
        ImageStruct(nameOfImage: "98", urlOfImage: "https://wattention.com/wp-content/uploads/2019/07/AKITA_COVER-800x597.jpg"),
        ImageStruct(nameOfImage: "99", urlOfImage: "https://akita.world/wp-content/uploads/2020/04/Akita-world.jpg"),
        ImageStruct(nameOfImage: "942", urlOfImage: "https://cdnn21.img.ria.ru/images/rsport/113350/33/1133503330_438:0:2486:2048_1920x0_80_0_0_8f13d0bf2d3f1aa354c8059f9c1afa8a.jpg"),
        ImageStruct(nameOfImage: "955", urlOfImage: "https://i.insider.com/5a31660ae29fa153008b45ce?width=1200&format=jpeg"),
        ImageStruct(nameOfImage: "966", urlOfImage: "https://www.thehealthydogco.com/wp-content/uploads/2020/10/How-Big-Can-Huskies-Get_The-Healthy-Dog-Co-1.jpg")
    ]
}
