#include "opencv2/core/core.hpp"
#include "opencv2/highgui/highgui.hpp"
#include <iostream>
#include <string>
#include <filesystem>

namespace fs = std::filesystem;

// must be using C++17
// 64-bit, release to run
int main(int argc, char** argv)
{
	// open original and watermark with rgba
	std::string opath = fs::current_path().string() + "\\images\\image2.png";
	std::string wpath = fs::current_path().string() + "\\images\\watermark2.png";
	std::string outpath = fs::current_path().string() + "\\images\\output.png";
	//std::cout << opath << std::endl;
	//bool exists = std::filesystem::exists(path);
	//std::cout << exists << std::endl;

    // open original and watermark with rgba
	cv::Mat original = cv::imread(opath, cv::IMREAD_UNCHANGED);
	cv::Mat watermark = cv::imread(wpath, cv::IMREAD_UNCHANGED);
	// copy the original to not modify it for the output
	cv::Mat copy = original;

	// check for invalid image input
	if (original.empty() || watermark.empty())
	{
		std::cout << "Could not open or find the image" << std::endl;
		return -1;
	}

	// make sure the images are the same size
	assert(original.size() == watermark.size());

	int cols, rows;
	cols = original.cols;
	rows = original.rows;
	int vals = 4;	// 4 values, rgba

	cv::Vec4b oRGBA, wRGBA, cRGBA;

	cv::Vec4b* orig_ptr = original.ptr<cv::Vec4b>();
	cv::Vec4b* wat_ptr = watermark.ptr<cv::Vec4b>();
	cv::Vec4b* copy_ptr = copy.ptr<cv::Vec4b>();

	// loop over the original pixel by pixel
	for (int i = 0; i < cols; i++)
		for (int j = 0; j < rows; j++)
		{
			// get rgba to check if the watermark has alpha+
			wRGBA = watermark.at<cv::Vec4b>(cv::Point(i, j));

			// get rgb of original pixel so it can be averaged
			oRGBA = original.at<cv::Vec4b>(cv::Point(i, j));
			cRGBA = copy.at<cv::Vec4b>(cv::Point(i, j));

			// modify the rgba
			for (int k = 0; k < vals; k++)
				cRGBA[k] = (oRGBA[k] + wRGBA[k]) / 2;

			copy.at<cv::Vec4b>(cv::Point(i, j)) = cRGBA;

			 
		}

	// loop over the original pixel by pixel
	//for (int i = 0; i < rows; i++)
	//	for (int j = 0; j < cols; j++)
	//		for (int k = 0; k < vals; k++)
	//			copy_ptr[i*rows + j][k] = (orig_ptr[i*rows + j][k] + wat_ptr[i*rows + j][k]) / 2;
	
	// save the output
	cv::imwrite(outpath, copy);

	// Create a window and display image
	cv::namedWindow("Display window", cv::WINDOW_AUTOSIZE);
    imshow("Display window", copy);
	cv::waitKey(0);

	cv::destroyAllWindows();

    return 0;
}