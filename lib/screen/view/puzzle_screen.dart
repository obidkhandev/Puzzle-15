import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puzzle_15/screen/controller.dart';
import 'package:url_launcher/url_launcher.dart';

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({super.key});

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  final PuzzleController controller = Get.put(PuzzleController());

  @override
  void initState() {
    controller.resetGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PuzzleController controller = Get.put(PuzzleController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '15 Puzzle',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove shadow
        flexibleSpace: Obx(
          () => Container(
            decoration: BoxDecoration(
              color: Color(controller.color.value),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Obx(() => Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(controller.color.value),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(controller.color.value),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Rangni o\'zgartirish',
                style: TextStyle(fontSize: 20,color: Color(controller.color.value)),
              ),
              trailing: Image.asset(
                "assets/images/change.png",
                width: 40,
              ),
              onTap: () {
                controller.randomColor();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Bizning boshqa loyihalar', style: TextStyle(fontSize: 20,color: Color(controller.color.value)),),
              trailing: Image.asset(
                "assets/images/hacker.png",
                width: 40,
              ),
              onTap: () async {
                if (await launchUrl(
                  Uri.parse("https://t.me/obidkhanswe"),
                )) {
                  throw Exception('Could not launch "https://t.me/obidkhanswe');
                }
              },
            ),
            ListTile(
              title: Text('Biz bilan bog\'lanish', style: TextStyle(fontSize: 20,color: Color(controller.color.value)),),
              trailing: Image.asset(
                "assets/images/contact.png",
                width: 40,
              ),
              onTap: () async {
                if (await launchUrl(
                  Uri.parse("https://t.me/obidkhanswe"),
                )) {
                  throw Exception('Could not launch "https://t.me/obidkhanswe');
                }
              },
            ),
            // Add more list tiles as needed
          ],
        ),)
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            "assets/images/clock.png",
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            '${controller.elapsedTime}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.resetGame();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              "assets/images/reset.png",
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Qayta boshlash',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset("assets/images/idea.png",
                              width: 30, height: 30),
                          SizedBox(width: 10),
                          Text(
                            '${controller.moveCount}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      color: Color(controller.color.value).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GridView.builder(
                      itemCount: controller.tiles.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: controller.gridSize,
                        mainAxisSpacing: 3,
                        crossAxisSpacing: 3,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => controller.moveTile(index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              color: controller.tiles[index] == 16
                                  ? Color(controller.color.value)
                                      .withOpacity(0.3)
                                  : Color(controller.color.value),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              controller.tiles[index] == 16
                                  ? ''
                                  : controller.tiles[index].toString(),
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
