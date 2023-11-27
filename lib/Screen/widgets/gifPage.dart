// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talklytic/Bloc/Trending_gif/trending_gif_bloc.dart';
import 'package:talklytic/Data/constants/color_constants.dart';

class GifPage extends StatefulWidget {
  const GifPage({super.key});

  @override
  State<GifPage> createState() => _GifPageState();
}

class _GifPageState extends State<GifPage> {
  @override
  void initState() {
    // context.read<TrendingGifBloc>().add(GetTrendingGif());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConstants.whiteShade,
      body: Column(
        children: [
          SizedBox(height: size.height * 0.015),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Reaction',
                style: TextStyle(
                  color: ColorConstants.blackShade,
                  fontFamily: GoogleFonts.manrope().fontFamily,
                  fontSize: size.height * 0.03,
                ),
              ),
            ],
          ),
          Divider(),
          SizedBox(height: size.height * 0.005),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            height: size.height * 0.05,
            decoration: BoxDecoration(
                border: Border.all(width: 0.3),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade200),
            child: TextField(
              cursorHeight: size.height * 0.02,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '   Search',
                  hintStyle: TextStyle(
                    fontFamily: GoogleFonts.manrope().fontFamily,
                  )),
            ),
          ),
          Divider(),
          SizedBox(height: size.height * 0.015),
          Expanded(
            child: BlocBuilder<TrendingGifBloc, TrendingGifState>(
              builder: (context, state) {
                if (state is TrendingGifLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TrendingInternetErrorState) {
                  return Center(
                    child: Text(state.errorMsg),
                  );
                } else if (state is TrendingGifErrorState) {
                  return Center(
                    child: Text(state.errorMsg),
                  );
                } else if (state is TrendingGifLoadedState) {
                  var mainModal = state.mainDataModal.data;

                  return GridView.builder(
                    itemCount: mainModal.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(5),
                        // color: Colors.amber.shade300,
                        height: size.height * 0.005,
                        width: size.width * 0.07,
                        child: Image.network(state
                            .mainDataModal.data[index].images.original.webp),
                        // child: ,
                      );
                    },
                  );
                }
                return Center(
                  child: Text('No Data found.....!'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
